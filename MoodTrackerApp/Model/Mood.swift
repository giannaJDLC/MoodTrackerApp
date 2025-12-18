//
//  Mood.swift
//  MoodTrackerApp
//
//  Created by Gianna Jolibeth on 11/30/25.
//

import Foundation

enum Mood: String, CaseIterable, Identifiable, Codable {
    case happy = "happy"
    case neutral = "neutral"
    case sad = "sad"
    case angry = "angry"
    case excited = "excited"
    case overwhelmed = "overwhelmed"
    
    var id: String { self.rawValue }
    
    var icon: String {
        switch self {
        case .happy: return "🙂"
        case .neutral: return "😐"
        case .sad: return "😞"
        case .angry: return "😠"
        case .excited: return "🤩"
        case .overwhelmed: return "😫"
        }
    }
    
    func localizedName(for language: AppLanguage) -> String {
       language.localize(self.rawValue)
    }
}
