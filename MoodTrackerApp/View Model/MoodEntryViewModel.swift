//
//  MoodEntryViewModel.swift
//  MoodTrackerApp
//
//  Created by Gianna Jolibeth on 12/9/25.
//

import Foundation
import SwiftData
import Combine

@MainActor
class MoodEntryViewModel: ObservableObject {
    private var modelContext: ModelContext
    private let settings: AppSettings
    private var cancellables = Set<AnyCancellable>()

    @Published var selectedMood: Mood?
    @Published var selectedThought: ThoughtCategory?
    @Published var selectedSlot: TimeSlot = .morning {
        didSet {
            loadExistingEntry()
        }
    }
    @Published private(set) var existingEntry: MoodEntry?
    @Published var showConfirmation = false
    @Published var confirmationMessage = ""
    @Published private(set) var currentTime = Date()

    init(modelContext: ModelContext, settings: AppSettings) {
        self.modelContext = modelContext
        self.settings = settings
        setupTimer()
        loadExistingEntry()
    }

    private func setupTimer() {
        Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .assign(to: \.currentTime, on: self)
            .store(in: &cancellables)
    }

    var isFormValid: Bool {
        selectedMood != nil && selectedThought != nil
    }

    private var targetDateForSelectedSlot: Date {
        let calendar = Calendar.current
        let scheduledTime = settings.notificationTimes[selectedSlot] ?? selectedSlot.defaultTime
        let components = calendar.dateComponents([.hour, .minute], from: scheduledTime)
        return calendar.date(bySettingHour: components.hour!, minute: components.minute!, second: 0, of: Date()) ?? Date()
    }

    var isSlotAccessible: Bool {
        let calendar = Calendar.current
        let targetStart = targetDateForSelectedSlot

        guard let targetEnd = calendar.date(byAdding: .hour, value: 1, to: targetStart)?
                                      .addingTimeInterval(-1) else { return false }

        return currentTime >= targetStart && currentTime <= targetEnd
    }

    var formattedTime: String {
        let scheduledTime = settings.notificationTimes[selectedSlot] ?? selectedSlot.defaultTime
        return scheduledTime.formatted(date: .omitted, time: .shortened)
    }

    var countdownString: String {
        let calendar = Calendar.current
        let targetStart = targetDateForSelectedSlot
        guard let nextHour = calendar.date(byAdding: .hour, value: 1, to: targetStart) else { return "N/A" }

        let remainingTime = nextHour.timeIntervalSince(currentTime)

        if remainingTime > 0 && remainingTime <= 3600 {
            let minutes = Int(remainingTime) / 60
            let seconds = Int(remainingTime) % 60
            let timeremaining = "\(minutes)m \(seconds)s"
            let action = existingEntry == nil ? "You have \(timeremaining) to create your entry" : "You have \(timeremaining) to edit your entry"

            return action
        }
        return ""
    }

    func loadExistingEntry() {
        Task {
            let calendar = Calendar.current
            let todayStart = calendar.startOfDay(for: Date())
            guard let tomorrowStart = calendar.date(byAdding: .day, value: 1, to: todayStart) else { return }

            let targetSlotRawValue = selectedSlot.rawValue

            let predicate = #Predicate<MoodEntry> { entry in
                entry.date >= todayStart &&
                entry.date < tomorrowStart &&
                entry.timeSlotRawValue == targetSlotRawValue
            }

            do {
                let descriptor = FetchDescriptor(predicate: predicate)
                let existing = try modelContext.fetch(descriptor).first
                self.existingEntry = existing
                if let entry = existing {
                    self.selectedMood = entry.mood
                    self.selectedThought = entry.thoughtCategory
                } else {
                    self.selectedMood = nil
                    self.selectedThought = nil
                }
            } catch {
                print("Error fetching existing entry: \(error)")
            }
        }
    }

    func saveEntry() {
        guard let mood = selectedMood, let thought = selectedThought else { return }

        do {
            if let entryToUpdate = existingEntry {
                // UPDATE
                entryToUpdate.mood = mood
                entryToUpdate.thoughtCategory = thought
                entryToUpdate.date = Date() // Update timestamp to now
                confirmationMessage = "Entry Successfully Updated!"

            } else {
                // CREATE
                let newEntry = MoodEntry(
                    date: Date(),
                    timeSlot: selectedSlot,
                    mood: mood,
                    thoughtCategory: thought
                )
                modelContext.insert(newEntry)
                self.existingEntry = newEntry
                confirmationMessage = "Entry Successfully Saved!"
            }

            try modelContext.save()
            showConfirmation = true

        } catch {
            print("Error saving/updating entry: \(error)")
            confirmationMessage = "An error occurred while saving."
            showConfirmation = true
        }
    }
}

