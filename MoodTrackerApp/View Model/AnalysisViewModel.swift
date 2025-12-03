//
//  AnalysisViewModel.swift
//  MoodTrackerApp
//
//  Created by Gianna Jolibeth on 12/3/25.
//
import Foundation
import SwiftData

@Observable
class AnalysisViewModel {
    
    private(set) var weeklyAnalysis: [TimeSlot: Mood]?
    private(set) var monthlyAnalysis: MonthlyAnalysisResult?
    private(set) var usageAnalysis: UsageAnalysisResult?
    
    private let calendar = Calendar.current
    
    init() {}
    
    func update(entries: [MoodEntry]) {
        self.weeklyAnalysis = performWeeklyAnalysis(entries: entries)
        self.monthlyAnalysis = performMonthlyAnalysis(entries: entries)
        self.usageAnalysis = performUsageAnalysis(entries: entries)
    }
        
    private func performWeeklyAnalysis(entries: [MoodEntry]) -> [TimeSlot: Mood]? {
           let recentEntries = entries.filter { calendar.isDateInThisWeek($0.date) }
           guard !recentEntries.isEmpty else { return nil }
           
           let recentMoodsBySlot: [(TimeSlot, Mood)] = recentEntries.map { entry in
               (entry.timeSlot, entry.mood)
           }
           
           guard !recentMoodsBySlot.isEmpty else { return nil }
           
           var moodCounts: [TimeSlot: [Mood: Int]] = [:]
           
           for (slot, mood) in recentMoodsBySlot {
               moodCounts[slot, default: [:]][mood, default: 0] += 1
           }
           
           var dominantMoods: [TimeSlot: Mood] = [:]
           
           for (slot, counts) in moodCounts {
               if let dominant = counts.max(by: { $0.value < $1.value })?.key {
                   dominantMoods[slot] = dominant
               }
           }
           
           return dominantMoods
       }
    
    private func performMonthlyAnalysis(entries: [MoodEntry]) -> MonthlyAnalysisResult? {
        guard !entries.isEmpty else { return nil }
        
        let entriesByWeek = Dictionary(grouping: entries) { entry -> Date in
            return calendar.dateInterval(of: .weekOfYear, for: entry.date)?.start ?? entry.date
        }
        
        guard entriesByWeek.count > 1 else { return nil }
        
        var analysis: MonthlyAnalysisResult = [:]
        
        for (weekStart, weekEntries) in entriesByWeek {
            if let dominantMood = weekEntries.map({ $0.mood }).mostFrequent(),
               let dominantThought = weekEntries.map({ $0.thoughtCategory }).mostFrequent() {
                analysis[weekStart] = (dominantMood, dominantThought)
            }
        }
        
        return analysis
    }
    
    private func performUsageAnalysis(entries: [MoodEntry]) -> UsageAnalysisResult? {
        guard !entries.isEmpty else { return nil }
        
        let today = calendar.startOfDay(for: Date())
        
        guard let thirtyDaysAgo = calendar.date(byAdding: .day, value: -30, to: today) else { return nil }
        
        let entriesInPeriod = entries.filter { $0.date >= thirtyDaysAgo }
        guard !entriesInPeriod.isEmpty else { return nil }
        
        guard let firstEntryDate = entriesInPeriod.map({ $0.calendarDay }).min() else { return nil }
        
        var totalExpectedInputs = 0
        let totalRecordedInputs = entriesInPeriod.count
        
        var currentDate = firstEntryDate
        
        while currentDate <= today {
            totalExpectedInputs += TimeSlot.allCases.count
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
        }
        
        let totalMissedInputs = max(0, totalExpectedInputs - totalRecordedInputs)
        let missedPercentage = (Double(totalMissedInputs) / Double(totalExpectedInputs)) * 100.0
        
        return (totalExpectedInputs: totalExpectedInputs, totalRecordedInputs: totalRecordedInputs, totalMissedInputs: totalMissedInputs, missedPercentage: missedPercentage)
    }
}
