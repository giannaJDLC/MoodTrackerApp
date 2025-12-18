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
    
    private var language: AppLanguage { settings.language }

    var body: some View {
        NavigationView {
            List {
                // MARK: - Weekly Section
                Section(language.localize("AnalysisWeeklyTitle")) {
                    if let weeklyAnalysis = vm.weeklyAnalysis {
                        ForEach(weeklyAnalysis.sorted(by: { $0.key.rawValue < $1.key.rawValue }), id: \.key) { slot, dominantMood in
                            HStack {
                                Text(String(format: language.localize("SlotLabel").replacingOccurrences(of: "%s", with: "%@"), slot.localizedName(for: language)))
                                Spacer()
                                Text("\(dominantMood.icon) \(dominantMood.localizedName(for: language))")
                                    .fontWeight(.medium)
                            }
                        }
                    } else {
                        Text(language.localize("NoEntries7Days"))
                            .foregroundColor(.secondary)
                    }
                }
                
                // MARK: - Monthly Section
                Section(language.localize("AnalysisMonthlyTitle")) {
                    if let monthlyAnalysis = vm.monthlyAnalysis {
                        ForEach(monthlyAnalysis.sorted(by: { $0.key > $1.key }), id: \.key) { week, results in
                            VStack(alignment: .leading, spacing: 8) {
                                // Localized Week Date
                                Text(String(format: language.localize("WeekOf"), week.formatted(date: .abbreviated, time: .omitted)))
                                    .font(.headline)
                                
                                HStack {
                                    Text(language.localize("AvgMood"))
                                    Spacer()
                                    Text(results.dominantMood.localizedName(for: language))
                                        .fontWeight(.medium)
                                }
                                
                                HStack {
                                    Text(language.localize("CommonThought"))
                                    Spacer()
                                    Text(results.dominantThought.localizedName(for: language))
                                        .font(.subheadline)
                                        .multilineTextAlignment(.trailing)
                                }
                            }
                        }
                    } else {
                        Text(language.localize("NotEnoughMonthly"))
                            .foregroundColor(.secondary)
                    }
                }
                
                // MARK: - Usage Section
                Section(language.localize("AnalysisUsageTitle")) {
                    if let usageAnalysis = vm.usageAnalysis {
                        HStack {
                            Text(language.localize("TotalExpected"))
                            Spacer()
                            Text("\(usageAnalysis.totalExpectedInputs)")
                        }
                        HStack {
                            Text(language.localize("TotalRecorded"))
                            Spacer()
                            Text("\(usageAnalysis.totalRecordedInputs)")
                        }
                        HStack {
                            Text(language.localize("MissedCheckins"))
                            Spacer()
                            Text("\(usageAnalysis.totalMissedInputs)")
                                .fontWeight(.bold)
                                .foregroundColor(usageAnalysis.totalMissedInputs > 0 ? .red : .green)
                        }
                        .padding(.vertical, 4)
                        
                        // Localized percentage string
                        let percentageStr = String(format: "%.1f", usageAnalysis.missedPercentage)
                        Text(LocalizedStringKey(String(format: language.localize("UsageSuggestion"), percentageStr)))
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.top, 4)
                    } else {
                        Text(language.localize("NotEnoughUsage"))
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle(language.localize("AnalysisTitle"))
            .onChange(of: entries) {
                vm.update(entries: entries)
            }
            .onAppear {
                vm.update(entries: entries)
            }
        }
    }
}
