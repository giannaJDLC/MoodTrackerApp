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
    
    private var localizedTitle: String {
        settings.language.localize("SettingsTitle")
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(settings.language.localize("LanguageSettingsTitle")) {
                    Picker("App Language", selection: $settings.language) {
                        ForEach(AppLanguage.allCases) { lang in
                                Text(lang.rawValue).tag(lang)
                            }
                        }
                    }
                               
                NotificationTimeSection(settings: settings)
                
                Button(settings.language.localize("SaveButton")) {
                    settings.scheduleNotifications()
                    showSavedAlert = true
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.borderedProminent)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
            }
            .navigationTitle(localizedTitle)
            .alert(settings.language.localize("Times Saved Alert Title"), isPresented: $showSavedAlert) {
                        Button("OK") {}
            } message: {
                Text(settings.language.localize("Times Saved Alert Message"))
            }
        }
    }
}

struct NotificationTimeRow: View {
    let slot: TimeSlot
    @Binding var date: Date
    let isLocked: Bool
    let language: AppLanguage 
    
    private var hourBinding: Binding<Int> {
        Binding<Int>(
            get: {
                Calendar.current.component(.hour, from: date)
            },
            set: { newHour in
                let calendar = Calendar.current
                if let newDate = calendar.date(bySettingHour: newHour, minute: 0, second: 0, of: date) {
                    date = newDate
                }
            }
        )
    }

    var body: some View {
        HStack {
            Text(language.localize(slot.rawValue))
            Spacer()
            
            Picker("", selection: hourBinding) {
                ForEach(slot.hourRange, id: \.self) { hour in
                    Text(formatHour(hour))
                        .tag(hour)
                }
            }
            .disabled(isLocked)
        }
    }
    
    private func formatHour(_ hour: Int) -> String {
        let calendar = Calendar.current
        var components = DateComponents()
        components.hour = hour
        
        guard let date = calendar.date(from: components) else { return "\(hour):00" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"
        
        return formatter.string(from: date)
    }
    
}

private struct NotificationTimeSection: View {
    @Bindable var settings: AppSettings
    
    var body: some View {
        Section(settings.language.localize("NotificationSectionTitle")) {
            ForEach(TimeSlot.allCases) { slot in
                let lockStatus = isSlotLocked(slot: slot)
                
                NotificationTimeRow(
                    slot: slot,
                    date: Binding(
                        get: { settings.notificationTimes[slot]! },
                        set: { newDate in
                            settings.notificationTimes[slot] = newDate
                        }
                    ),
                    isLocked: lockStatus,
                    language: settings.language
                )
            }
        }
    }
    
    private func isSlotLocked(slot: TimeSlot) -> Bool {
        let scheduledTime = settings.notificationTimes[slot] ?? slot.defaultTime
        let calendar = Calendar.current
        let now = Date()
        
        let scheduledHour = calendar.component(.hour, from: scheduledTime)
        
        guard let scheduledStartToday = calendar.date(bySettingHour: scheduledHour, minute: 0, second: 0, of: now) else {
            return false
        }
        
        return now >= scheduledStartToday
    }

}
