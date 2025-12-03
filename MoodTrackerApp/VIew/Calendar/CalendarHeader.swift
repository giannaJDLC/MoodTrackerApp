//
//  CalendarHeader.swift
//  MoodTrackerApp
//
//  Created by Gianna Jolibeth on 12/1/25.
//

import SwiftUI

struct CalendarHeader: View {
       @Binding var currentDate: Date
       private let calendar = Calendar.current
       
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
                   }
                   
                   Spacer()
                   
                   if isCurrentMonth {
                       Text(currentDate, style: .date) // Full date
                           .font(.title3)
                           .fontWeight(.bold)
                   } else {
                       Text(currentDate, format: .dateTime.month(.wide).year()) // Month and Year
                           .font(.title3)
                           .fontWeight(.bold)
                   }
                   
                   Spacer()
                   
                   Button(action: {
                       currentDate = calendar.date(byAdding: .month, value: 1, to: currentDate) ?? currentDate
                   }) {
                       Image(systemName: "chevron.right.circle.fill")
                   }
               }
               .padding(.horizontal)
               
               HStack {
                   ForEach(calendar.shortWeekdaySymbols, id: \.self) { symbol in
                       Text(symbol.prefix(1))
                           .fontWeight(.medium)
                           .frame(maxWidth: .infinity)
                           .foregroundColor(.secondary)
                   }
               }
               .padding(.horizontal)
           }
       }
   }
