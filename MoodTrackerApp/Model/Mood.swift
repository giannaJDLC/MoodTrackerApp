//
//  Mood.swift
//  MoodTrackerApp
//
//  Created by Gianna Jolibeth on 11/30/25.
//

import Foundation

enum Mood: String, CaseIterable, Identifiable, Codable {
    case angry = "😠 Angry"
    case neutral = "😐 Neutral"
    case sad = "😞 Sad"
    case happy = "🙂 Happy"
    case excited = "🤩 Excited"
    
    var id: String { self.rawValue }
    var icon: String { String(self.rawValue.prefix(2)) }
}
