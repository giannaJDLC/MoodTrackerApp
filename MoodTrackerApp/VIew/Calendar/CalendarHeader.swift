//
//  CalendarHeader.swift
//  MoodTrackerApp
//
//  Created by Gianna Jolibeth on 12/1/25.
//

import SwiftUI

struct CalendarHeader: View {
    @Binding var currentDate: Date
    @Bindable var settings: AppSettings
    
    private let calendar = Calendar.current
    
    private var locale: Locale {
        Locale(identifier: settings.language == .spanish ? "es_ES" : "en_US")
    }
    
    var isCurrentMonth: Bool {
        calendar.isDate(currentDate, equalTo: Date(), toGranularity: .month)
    }
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Button(action: {
                    currentDate = calendar.date(byAdding: .month, value: -1, to: currentDate) ?? currentDate
                }) {
                    Image(systemName: "chevron.left.circle.fill")
                        .font(.title2)
                }
                
                Spacer()
                
                Group {
                    if isCurrentMonth {
                                           // Full date localized and capitalized
                                           let dateString = currentDate.formatted(.dateTime.day().month().year().locale(locale))
                                           Text(dateString.capitalized(with: locale))
                                       } else {
                                           // Month and Year localized and capitalized
                                           let dateString = currentDate.formatted(.dateTime.month(.wide).year().locale(locale))
                                           Text(dateString.capitalized(with: locale))
                                       }
                }
                .font(.title3)
                .fontWeight(.bold)
                .animation(.none, value: currentDate)
                
                Spacer()
                
                Button(action: {
                    currentDate = calendar.date(byAdding: .month, value: 1, to: currentDate) ?? currentDate
                }) {
                    Image(systemName: "chevron.right.circle.fill")
                        .font(.title2)
                }
            }
            .padding(.horizontal)
            
            // Weekday symbols (S M T W T F S) localized
            HStack {
                let symbols = settings.language == .spanish ?
                    ["D", "L", "M", "M", "J", "V", "S"] :
                    calendar.veryShortWeekdaySymbols
                
                ForEach(symbols, id: \.self) { symbol in
                    Text(symbol)
                        .font(.caption)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal)
            .padding(.top, 4)
        }
    }
}
