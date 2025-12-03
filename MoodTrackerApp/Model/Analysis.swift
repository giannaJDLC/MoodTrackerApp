//
//  Analysis.swift
//  MoodTrackerApp
//
//  Created by Gianna Jolibeth on 12/3/25.
//
import Foundation

typealias UsageAnalysisResult = (totalExpectedInputs: Int, totalRecordedInputs: Int, totalMissedInputs: Int, missedPercentage: Double)
typealias MonthlyAnalysisResult = [Date: (dominantMood: Mood, dominantThought: ThoughtCategory)]

