//
//  MoodSelectionView.swift
//  MoodTrackerApp
//
//  Created by Gianna Jolibeth on 12/9/25.
//

import Foundation
import SwiftUI

struct MoodSelectionView: View {
    @ObservedObject var viewModel: MoodEntryViewModel
    
    private var language: AppLanguage { viewModel.settings.language }
    
    private var localizedTitle: String {
        language.localize("SelectMood")
    }
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(localizedTitle)
                .font(.headline)
                .foregroundColor(.primary)
            
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(Mood.allCases) { mood in
                    Button {
                        viewModel.selectedMood = mood
                    } label: {
                        VStack(spacing: 6) {
                            Text(mood.icon)
                                .font(.largeTitle)
                            
                            Text(mood.localizedName(for: language))
                                .font(.caption)
                                .fontWeight(.medium)
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(viewModel.selectedMood == mood ? Color.green.opacity(0.2) : Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(viewModel.selectedMood == mood ? Color.green : Color.clear, lineWidth: 2)
                        )
                        .scaleEffect(viewModel.selectedMood == mood ? 1.05 : 1.0)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(.horizontal)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: viewModel.selectedMood)
    }
}
