//
//  ContentView.swift
//  MoodTrackerApp
//
//  Created by Gianna Jolibeth on 11/26/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var settings = AppSettings()
       
       var body: some View {
           TabView {
               MoodEntryView(settings: settings)
                   .tabItem { Label("Entry", systemImage: "pencil.circle.fill") }
               
               CalendarView()
                   .tabItem { Label("History", systemImage: "calendar") }
               
               AnalysisView()
                   .tabItem { Label("Analysis", systemImage: "chart.bar.xaxis") }
               
               SettingsView(settings: settings)
                   .tabItem { Label("Settings", systemImage: "gearshape.fill") }
           }
       }
}

#Preview {
    ContentView()
        .modelContainer(for: MoodEntry.self, inMemory: true)
}
