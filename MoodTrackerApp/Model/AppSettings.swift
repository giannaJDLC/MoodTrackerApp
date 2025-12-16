//
//  AppSettings.swift
//  MoodTrackerApp
//
//  Created by Gianna Jolibeth on 11/30/25.
//
import SwiftUI
import UserNotifications
import SwiftData

@Model
final class AppSettings {
    var _notificationTimesRaw: [String: Date]
    
    @Transient var notificationTimes: [TimeSlot: Date] {
        get {
            return _notificationTimesRaw.reduce(into: [:]) { result, element in
                if let slot = TimeSlot(rawValue: element.key) {
                    result[slot] = element.value
                }
            }
        }
        set {
            let rawDictionaryArray = newValue.map { ($0.key.rawValue, $0.value) }
            self._notificationTimesRaw = Dictionary(uniqueKeysWithValues: rawDictionaryArray)
            print("✅ SETTER: _notificationTimesRaw updated.")
        }
    }
    
    init() {
        self._notificationTimesRaw = [
            TimeSlot.morning.rawValue: TimeSlot.morning.defaultTime,
            TimeSlot.afternoon.rawValue: TimeSlot.afternoon.defaultTime,
            TimeSlot.evening.rawValue: TimeSlot.evening.defaultTime
        ]
        requestNotificationPermission()
    }
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                self.scheduleNotifications()
            } else {
                print("Permission denied.")
            }
        }
    }
    
    func scheduleNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        for (slot, date) in notificationTimes {
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            let minute = calendar.component(.minute, from: date)
            
            var dateComponents = DateComponents()
            dateComponents.hour = hour
            dateComponents.minute = minute
            
            let content = UNMutableNotificationContent()
            content.title = "Mood Check-in: \(slot.rawValue)"
            content.body = "Time to check in! How are you feeling?"
            content.sound = UNNotificationSound.default
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: "mood-checkin-\(slot.rawValue)", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification for \(slot.rawValue): \(error.localizedDescription)")
                }
            }
        }
    }
}
