//
//  MoodEntryView.swift
//  MoodTrackerApp
//
//  Created by Gianna Jolibeth on 11/30/25.
//
import SwiftUI
import SwiftData

struct MoodEntryView: View {
    @Bindable var settings: AppSettings
    @StateObject private var viewModel: MoodEntryViewModel

    init(settings: AppSettings, modelContext: ModelContext) {
        self._settings = Bindable(settings)
        self._viewModel = StateObject(wrappedValue: MoodEntryViewModel(modelContext: modelContext, settings: settings))
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Picker("Time Slot", selection: $viewModel.selectedSlot) {
                        ForEach(TimeSlot.allCases) { slot in
                            Text(slot.localizedName(for: settings.language)).tag(slot)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)

                    if viewModel.isSlotAccessible {
                        Text(viewModel.countdownString)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.red.opacity(0.8))
                    }

                    ZStack {
                        VStack(spacing: 20) {
                            MoodSelectionView(viewModel: viewModel)
                            Divider()
                            ThoughtSelectionView(viewModel: viewModel)
                            Button(viewModel.localizedSaveButtonText) {
                                viewModel.saveEntry()
                            }
                            .disabled(!viewModel.isFormValid)
                            .buttonStyle(.borderedProminent)
                            .controlSize(.large)
                        }
                        if !viewModel.isSlotAccessible {
                            BlockedTimeSlot(viewModel: viewModel, formattedTime: viewModel.formattedTime)
                        }
                    }
                }
                .navigationTitle(viewModel.localizedTitle)
                .alert(viewModel.confirmationMessage, isPresented: $viewModel.showConfirmation) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text(viewModel.confirmationMessage)
                }
            }

        }
    }
}
