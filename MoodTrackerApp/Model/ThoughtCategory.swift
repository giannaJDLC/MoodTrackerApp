//
//  ThoughtCategory.swift
//  MoodTrackerApp
//
//  Created by Gianna Jolibeth on 11/30/25.
//

import Foundation

enum ThoughtCategory: String, CaseIterable, Identifiable, Codable {
    case practical = "practical"
       case emotional = "emotional"
       case inspirational = "inspirational"
       case other = "other"
       
       var id: String { self.rawValue }
       
       func localizedName(for language: AppLanguage) -> String {
           language.localize(self.rawValue)
       }
}
