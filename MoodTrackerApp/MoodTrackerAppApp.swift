//
//  MoodTrackerAppApp.swift
//  MoodTrackerApp
//
//  Created by Gianna Jolibeth on 11/26/25.
//

import SwiftUI
import SwiftData

@main
struct MoodTrackerApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: MoodEntry.self) 
    }
    
    
}
