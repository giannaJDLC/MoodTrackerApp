//
//  SettingsView.swift
//  MoodTrackerApp
//
//  Created by Gianna Jolibeth on 11/30/25.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Bindable var settings: AppSettings
    @State private var showSavedAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                NotificationTimeSection(settings: settings)
                
                Button("Save and Update Notifications") {
                    settings.scheduleNotifications()
                    showSavedAlert = true
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Settings")
            .alert("Times Saved", isPresented: $showSavedAlert) {
                Button("OK") {}
            } message: {
                Text("Your new notification times have been scheduled.")
            }
        }
    }
}

struct NotificationTimeRow: View {
    let slot: TimeSlot
    @Binding var date: Date
    
    var body: some View {
        HStack {
            Text(slot.rawValue)
            Spacer()
            DatePicker("", selection: $date, displayedComponents: .hourAndMinute)
        }
    }
}

private struct NotificationTimeSection: View {
    @Bindable var settings: AppSettings

    var body: some View {
        Section("Notification Check-in Times") {
            ForEach(TimeSlot.allCases) { slot in
                NotificationTimeRow(
                    slot: slot,
                    date: Binding(
                        get: { settings.notificationTimes[slot]! },
                        set: { settings.notificationTimes[slot] = $0 }
                    )
                )
            }
        }
    }
}

