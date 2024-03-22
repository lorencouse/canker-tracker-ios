//
//  CustomSliders.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/3/20.
//

import Foundation
import SwiftUI

struct SoreSizeSlider: View {
    @Binding var selectedSore: CankerSore
    
    var body: some View {
        HStack {
            Text("Size: \(Int(selectedSore.soreSize.last ?? 3)) mm")
            Slider(value: Binding(
                get: { self.selectedSore.soreSize.last ?? 3 },
                set: { newValue in
                    // Directly update the last value of soreSize
                    self.selectedSore.soreSize[self.selectedSore.soreSize.count - 1] = newValue
                }
            ), in: 0...20, step: 1)
        }
    }
}

struct PainScoreSlider: View {
    @Binding var selectedSore: CankerSore
    
    var body: some View {
        HStack {
            Text("Pain: \(Int(selectedSore.painLevel.last ?? 3))")
            Slider(value: Binding(
                get: { self.selectedSore.painLevel.last ?? 3 },
                set: { newValue in
                    // Directly update the last value of painLevel
                    self.selectedSore.painLevel[self.selectedSore.painLevel.count - 1] = newValue
                }
            ), in: 0...10, step: 1)
        }
    }
}

