//
//  CalendarViewModel.swift
//  MoodTrackerApp
//
//  Created by Gianna Jolibeth on 12/1/25.
//

import Foundation
import SwiftData
import SwiftUI

@Observable
class CalendarViewModel {
    private let calendar = Calendar.current

    private(set) var daysInCurrentMonth: [Date?] = []
    
    private var entriesByDay: [Date: [MoodEntry]] = [:]

    init() {}
    
    func update(currentDate: Date, allEntries: [MoodEntry]) {
        self.entriesByDay = Dictionary(grouping: allEntries, by: { $0.calendarDay })
        self.daysInCurrentMonth = calculateDaysInMonth(for: currentDate)
    }

    func getEntries(for day: Date?) -> [MoodEntry] {
        guard let day = day else {
            return []
        }
        return entriesByDay[day] ?? []
    }
    
    private func calculateDaysInMonth(for date: Date) -> [Date?] {
        //what month are we in? How many days does it have?
        guard let monthStart = calendar.date(from: calendar.dateComponents([.year, .month], from: date)),
              let range = calendar.range(of: .day, in: .month, for: monthStart) else { return [] }
        
        var allDays: [Date?] = []
        
        //what day of the week does the start of the month fall on?
        let firstWeekday = calendar.component(.weekday, from: monthStart)
        let leadingBlanks = (firstWeekday - calendar.firstWeekday + 7) % 7

        for _ in 0..<leadingBlanks {
            allDays.append(nil)
        }
        
        for i in range {
            if let date = calendar.date(byAdding: .day, value: i - 1, to: monthStart) {
                allDays.append(date)
            }
        }
        
        return allDays
    }
}
