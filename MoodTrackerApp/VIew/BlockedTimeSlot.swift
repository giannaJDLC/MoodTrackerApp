//
//  BlockedTimeSlot.swift
//  MoodTrackerApp
//
//  Created by Gianna Jolibeth on 12/6/25.
//

import SwiftUI


struct BlockedTimeSlot: View {
    var formattedTime: String
    
    var body: some View {
           VStack {
               Spacer()
               Text("Time Slot Locked")
                   .font(.title)
                   .fontWeight(.bold)
                   .padding(.bottom, 5)
               
               Text("This entry is only accessible during its scheduled one-hour window, which starts at **\(formattedTime)**.")
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
