//
//  CalendarView.swift
//  MoodTrackerApp
//
//  Created by Gianna Jolibeth on 11/30/25.
//

import SwiftUI
import SwiftData

struct CalendarView: View {
    @Query(sort: [SortDescriptor(\MoodEntry.date, order: .reverse)]) var entries: [MoodEntry]
    
    @Bindable var settings: AppSettings
        
    @State private var currentDate = Date()
    @State private var vm = CalendarViewModel()
    
    private var localizedTitle: String {
           settings.language.localize("HistoryTitle")
       }
    
    var body: some View {
        NavigationView {
            VStack {
                CalendarHeader(currentDate: $currentDate)
                
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                        ForEach(vm.daysInCurrentMonth, id: \.self) { day in
                            DayCell(day: day,entries: vm.getEntries(for: day))
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle(localizedTitle)
            
            // when the view first loads
            .onAppear {
                vm.update(currentDate: currentDate, allEntries: entries)
            }
            // when the user changes the month (currentDate changes)
            .onChange(of: currentDate) {
                vm.update(currentDate: currentDate, allEntries: entries)
            }
            // when the database data changes (entries changes)
            .onChange(of: entries) {
                vm.update(currentDate: currentDate, allEntries: entries)
            }
        }
    }
    
}
