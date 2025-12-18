//
//  ContentView.swift
//  MoodTrackerApp
//
//  Created by Gianna Jolibeth on 11/26/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var persistedSettings: [AppSettings]
    
    @State private var currentSettings: AppSettings?
    @State private var settings = AppSettings()
       
       var body: some View {
           if let settings = currentSettings {
                      TabView {
                          MoodEntryView(settings: settings, modelContext: modelContext)
                              .tabItem { Label(settings.language.localize("EntryTitle"), systemImage: "pencil.circle.fill") }
                          
                          CalendarView(settings: settings)
                              .tabItem { Label(settings.language.localize("HistoryTitle"), systemImage: "calendar") }
                          
                          AnalysisView(settings: settings)
                              .tabItem { Label(settings.language.localize("AnalysisTitle"), systemImage: "chart.bar.xaxis") }
                          
                          SettingsView(settings: settings)
                              .tabItem { Label(settings.language.localize("SettingsTitle"), systemImage: "gearshape.fill") }
                      }
                  } else {
                      ProgressView("Loading Settings...")
                          .onAppear {
                              if let existingSettings = persistedSettings.first {
                                  self.currentSettings = existingSettings
                              } else {
                                  let newSettings = AppSettings()
                                  modelContext.insert(newSettings)
                                  self.currentSettings = newSettings
                              }
                          }
                  }
       }
}

#Preview {
    ContentView()
        .modelContainer(for: [MoodEntry.self, AppSettings.self], inMemory: true)
}
