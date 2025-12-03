//
//  ThoughtCategory.swift
//  MoodTrackerApp
//
//  Created by Gianna Jolibeth on 11/30/25.
//

import Foundation

enum ThoughtCategory: String, CaseIterable, Identifiable, Codable {
    case practical = "Practical / Task-oriented"
    case emotional = "Emotional / Feeling-based"
    case inspirational = "Inspirational / Motivational"
    case fog = "Brain Fog / I don't Know"
    
    var id: String { self.rawValue }
}
