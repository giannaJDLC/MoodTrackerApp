//
//  AppSettings.swift
//  MoodTrackerApp
//
//  Created by Gianna Jolibeth on 11/30/25.
//
import SwiftUI
import UserNotifications
import SwiftData

@Observable
class AppSettings {
    var notificationTimes: [TimeSlot: Date] = [
        .morning: TimeSlot.morning.defaultTime,
        .afternoon: TimeSlot.afternoon.defaultTime,
        .evening: TimeSlot.evening.defaultTime
    ]
    
    init() {
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
