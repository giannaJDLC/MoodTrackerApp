//
//  BlockedTimeSlot.swift
//  MoodTrackerApp
//
//  Created by Gianna Jolibeth on 12/6/25.
//

import SwiftUI

struct BlockedTimeSlot: View {
    var viewModel: MoodEntryViewModel
    var formattedTime: String
    
    private var localizedSlotName: String {
        viewModel.selectedSlot.localizedName(for: viewModel.settings.language)
    }
    
    private var localizedTitle: String {
        viewModel.settings.language.localize("SlotBlockedTitle")
    }
    
    private var localizedMessage: String {
        let template = viewModel.settings.language.localize("SlotBlockedMessage")
        
        return String(format: template.replacingOccurrences(of: "%s", with: "%@"), localizedSlotName.lowercased(), viewModel.formattedTime)
    }
    
    
    var body: some View {
           VStack {
               Spacer()
               Text(localizedTitle)
                   .font(.title)
                   .fontWeight(.bold)
                   .padding(.bottom, 5)
               
               Text(localizedMessage)
                   .multilineTextAlignment(.center)
                   .padding(.horizontal)
               Spacer()
           }
           .frame(maxWidth: .infinity, maxHeight: .infinity)
           .background(.ultraThinMaterial) 
           .transition(.opacity)
           .allowsHitTesting(true)
       }
}
