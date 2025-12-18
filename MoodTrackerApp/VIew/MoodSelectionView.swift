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
    
    private var localizedTitle: String {
        viewModel.settings.language.localize("SelectMood")
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(localizedTitle)
                .font(.headline)
                .foregroundColor(.primary)
            
            HStack {
                ForEach(Mood.allCases) { mood in
                    Button {
                        viewModel.selectedMood = mood
                    } label: {
                        VStack(spacing: 6) {
                            Text(mood.icon)
                                .font(.largeTitle)
                            Text(mood.localizedName(for: viewModel.settings.language))
                                .font(.caption)
                        }
                        .padding(10)
                        .background(viewModel.selectedMood == mood ? Color.green.opacity(0.2) : Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .scaleEffect(viewModel.selectedMood == mood ? 1.1 : 1.0)
                        .animation(.spring, value: viewModel.selectedMood)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(.horizontal)
    }
}
