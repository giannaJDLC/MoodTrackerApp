//
//  TimeSlot.swift
//  MoodTrackerApp
//
//  Created by Gianna Jolibeth on 11/30/25.
//

import Foundation

enum TimeSlot: String, CaseIterable, Identifiable, Codable {
    case morning = "Morning"
    case afternoon = "Afternoon"
    case evening = "Evening"
    var id: String { self.rawValue }
    
    var hourRange: ClosedRange<Int> {
        switch self {
        case .morning: return 0...11
        case .afternoon: return 12...17
        case .evening: return 18...23   
        }
    }
    
    var defaultTime: Date {
        let calendar = Calendar.current
        var components = DateComponents()
        
        switch self {
        case .morning: components.hour = 9
        case .afternoon: components.hour = 13
        case .evening: components.hour = 20
        }
        
        return calendar.date(from: components) ?? Date()
    }
}
