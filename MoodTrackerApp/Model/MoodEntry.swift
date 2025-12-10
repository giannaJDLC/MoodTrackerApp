//
//  MoodEntry.swift
//  MoodTrackerApp
//
//  Created by Gianna Jolibeth on 11/26/25.
//

import Foundation
import SwiftData

@Model
final class MoodEntry {
    var id = UUID()
    var date: Date
    var mood: Mood
    var thoughtCategory: ThoughtCategory
    var timeSlotRawValue: String
    
    var calendarDay: Date {
        Calendar.current.startOfDay(for: date)
    }
    
    @Transient
    var timeSlot: TimeSlot {
            get { TimeSlot(rawValue: self.timeSlotRawValue) ?? .morning } // Provide a default fallback
            set { self.timeSlotRawValue = newValue.rawValue }
        }
    
    init(date: Date, timeSlot: TimeSlot, mood: Mood, thoughtCategory: ThoughtCategory) {
        self.date = date
        self.timeSlotRawValue = timeSlot.rawValue
        self.mood = mood
        self.thoughtCategory = thoughtCategory
    }
    

}
