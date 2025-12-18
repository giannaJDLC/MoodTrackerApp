//
//  AnalysisView.swift
//  MoodTrackerApp
//
//  Created by Gianna Jolibeth on 11/30/25.
//

import SwiftUI
import SwiftData
struct AnalysisView: View {
    @Query(sort: [SortDescriptor(\MoodEntry.date, order: .reverse)]) var entries: [MoodEntry]
    @State private var vm = AnalysisViewModel()
    @Bindable var settings: AppSettings
    
    private var localizedTitle: String {
        settings.language.localize("AnalysisTitle")
    }
    
    var body: some View {
        NavigationView {
            List {
                Section("Weekly Analysis: Time of Day Patterns") {
                    if let weeklyAnalysis = vm.weeklyAnalysis {
                        ForEach(weeklyAnalysis.sorted(by: { $0.key.rawValue < $1.key.rawValue }), id: \.key) { slot, dominantMood in
                            HStack {
                                Text("\(slot.rawValue) Slot:")
                                Spacer()
                                Text(dominantMood.icon + " \(dominantMood.rawValue.components(separatedBy: " ").last ?? "")")
                                    .fontWeight(.medium)
                            }
                        }
                    } else {
                        Text("No entries in the last 7 days.")
                            .foregroundColor(.secondary)
                    }
                }
                
                Section("Monthly Analysis: Weekly Averages") {
                    if let monthlyAnalysis = vm.monthlyAnalysis {
                        ForEach(monthlyAnalysis.sorted(by: { $0.key > $1.key }), id: \.key) { week, results in
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Week of \(week, style: .date)")
                                    .font(.headline)
                                
                                HStack {
                                    Text("Avg Mood:")
                                    Spacer()
                                    Text(results.dominantMood.icon + " \(results.dominantMood.rawValue.components(separatedBy: " ").last ?? "")")
                                        .fontWeight(.medium)
                                }
                                
                                HStack {
                                    Text("Most Common Thought:")
                                    Spacer()
                                    Text(results.dominantThought.rawValue)
                                        .font(.subheadline)
                                        .multilineTextAlignment(.trailing)
                                }
                            }
                        }
                    } else {
                        Text("Not enough data (less than 2 weeks) for monthly analysis.")
                            .foregroundColor(.secondary)
                    }
                }
                
                Section("Usage Analysis: Missed Check-ins (Last 30 Days)") {
                    if let usageAnalysis = vm.usageAnalysis {
                        HStack {
                            Text("Total Expected Inputs:")
                            Spacer()
                            Text("\(usageAnalysis.totalExpectedInputs)")
                        }
                        HStack {
                            Text("Total Recorded Inputs:")
                            Spacer()
                            Text("\(usageAnalysis.totalRecordedInputs)")
                        }
                        HStack {
                            Text("Missed Check-ins:")
                            Spacer()
                            Text("\(usageAnalysis.totalMissedInputs)")
                                .fontWeight(.bold)
                                .foregroundColor(usageAnalysis.totalMissedInputs > 0 ? .red : .green)
                        }
                        .padding(.vertical, 4)
                        
                        Text("This suggests **\(String(format: "%.1f", usageAnalysis.missedPercentage))%** of check-ins were missed.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.top, 4)
                    } else {
                        Text("Not enough data to track usage.")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle(localizedTitle)
            .onChange(of: entries) {
                vm.update(entries: entries)
            }
            .onAppear {
                vm.update(entries: entries)
            }
        }
    }
}
