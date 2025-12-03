//
//  DayCell.swift
//  MoodTrackerApp
//
//  Created by Gianna Jolibeth on 12/1/25.
//

import SwiftUI

struct DayCell: View {
    let day: Date?
    let entries: [MoodEntry]
    private let calendar = Calendar.current
    
    var isToday: Bool {
        guard let day = day else { return false }
        return calendar.isDateInToday(day)
    }
    
    private var entryMap: [TimeSlot: MoodEntry] {
        Dictionary(entries.compactMap { ($0.timeSlot, $0) },
                   uniquingKeysWith: { (first, _) in first })
    }
    
    var body: some View {
        if let day = day {
            VStack(spacing: 2) {
                Text("\(calendar.component(.day, from: day))")
                    .font(.caption2)
                    .fontWeight(isToday ? .bold : .regular)
                    .foregroundColor(.primary)
                    .padding(.bottom, 2)
                
                VStack(spacing: 1) {
                    ForEach(TimeSlot.allCases.map { $0 }, id: \.self) { slot in
                        TimeSlotEntryRow(entry: entryMap[slot])
                    }
                }
                
            }
            .frame(height: 90)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isToday ? Color.yellow.opacity(0.3) : (entries.isEmpty && !calendar.isDateInToday(day) ? Color.clear : Color.gray.opacity(0.1)))
            )
        } else {
            Rectangle()
                .fill(Color.clear)
                .frame(height: 90)
                .frame(maxWidth: .infinity)
        }
    }
    
    private struct TimeSlotEntryRow: View {
        let entry: MoodEntry?
        
        var body: some View {
            HStack(spacing: 2) {
                if let entry = entry {
                    Text(entry.date.formatted(.dateTime.hour(.defaultDigits(amPM: .abbreviated))))
                        .font(.system(size: 8))
                        .fontWeight(.medium)
                        .frame(width: 30, alignment: .leading)
                        .foregroundColor(.secondary)
                    
                    Text(entry.mood.icon)
                        .font(.caption)
                        .frame(width: 16)
                } else {
                    Text("—")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text(" ")
                        .font(.caption)
                }
            }
        }
    }
   }
