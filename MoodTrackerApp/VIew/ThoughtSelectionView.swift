//
//  ThoughtSelectionView.swift
//  MoodTrackerApp
//
//  Created by Gianna Jolibeth on 12/9/25.
//
import Foundation
import SwiftUI

struct ThoughtSelectionView: View {
    @ObservedObject var viewModel: MoodEntryViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("2. Describe your current thought pattern:")
                .font(.headline)
                .foregroundColor(.primary)

            VStack(alignment: .leading, spacing: 10) {
                ForEach(ThoughtCategory.allCases) { category in
                    Button {
                        viewModel.selectedThought = category
                    } label: {
                        HStack {
                            Text(category.rawValue)
                            Spacer()
                            if viewModel.selectedThought == category {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            }
                        }
                        .padding()
                        .background(viewModel.selectedThought == category ? Color.green.opacity(0.1) : Color.clear)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(viewModel.selectedThought == category ? Color.green : Color.gray.opacity(0.3), lineWidth: 1)
                        )
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}
