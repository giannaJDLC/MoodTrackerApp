//
//  MoodEntryView.swift
//  MoodTrackerApp
//
//  Created by Gianna Jolibeth on 11/30/25.
//
import SwiftUI
import SwiftData

struct MoodEntryView: View {
    @Environment(\.modelContext) private var modelContext // Inject Model Context
    @Bindable var settings: AppSettings
    @State private var selectedMood: Mood?
    @State private var selectedThought: ThoughtCategory?
    @State private var selectedSlot: TimeSlot = .morning
    @State private var showConfirmation = false
    
    var isFormValid: Bool {
        selectedMood != nil && selectedThought != nil
    }
    
    func saveEntry() {
        if let mood = selectedMood, let thought = selectedThought {
            let newEntry = MoodEntry(
                date: Date(),
                timeSlot: selectedSlot,
                mood: mood,
                thoughtCategory: thought
            )
            
            modelContext.insert(newEntry)
            
            selectedMood = nil
            selectedThought = nil
            showConfirmation = true
        }
    }
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                Picker("Time Slot", selection: $selectedSlot) {
                    ForEach(TimeSlot.allCases) { slot in
                        Text(slot.rawValue).tag(slot)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("1. How are you feeling?")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    HStack {
                        ForEach(Mood.allCases) { mood in
                            Button {
                                selectedMood = mood
                            } label: {
                                VStack(spacing: 4) { 
                                    Text(mood.icon)
                                        .font(.largeTitle)
                                    Text(mood.rawValue.components(separatedBy: " ").last ?? "")
                                        .font(.caption)
                                }
                                .padding(10)
                                .background(selectedMood == mood ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
                                .cornerRadius(10)
                                .scaleEffect(selectedMood == mood ? 1.1 : 1.0)
                                .animation(.spring, value: selectedMood)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("2. Describe your current thought pattern:")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(ThoughtCategory.allCases) { category in
                            Button {
                                selectedThought = category
                            } label: {
                                HStack {
                                    Text(category.rawValue)
                                    Spacer()
                                    if selectedThought == category {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.blue)
                                    }
                                }
                                .padding()
                                .background(selectedThought == category ? Color.green.opacity(0.1) : Color.clear)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(selectedThought == category ? Color.green : Color.gray.opacity(0.3), lineWidth: 1)
                                )
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button("Save Entry") {
                    saveEntry()
                }
                .disabled(!isFormValid)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                
            }
            .navigationTitle("Daily Check-in")
            .alert("Entry Saved!", isPresented: $showConfirmation) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Your mood and thought pattern have been successfully recorded for the \(selectedSlot.rawValue) slot.")
            }
        }
    }
}
