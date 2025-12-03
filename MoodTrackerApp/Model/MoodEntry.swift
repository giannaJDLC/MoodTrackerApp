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
    var timeSlot: TimeSlot
    var mood: Mood
    var thoughtCategory: ThoughtCategory
    
    init(date: Date, timeSlot: TimeSlot, mood: Mood, thoughtCategory: ThoughtCategory) {
        self.date = date
        self.timeSlot = timeSlot
        self.mood = mood
        self.thoughtCategory = thoughtCategory
    }
    
    var calendarDay: Date {
        Calendar.current.startOfDay(for: date)
    }
}
