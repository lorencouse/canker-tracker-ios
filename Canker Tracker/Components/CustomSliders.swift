//
//  CustomSliders.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/3/20.
//

import Foundation
import SwiftUI

struct SoreSizeSlider: View {
    @Binding var selectedSore: CankerSore?
    
    var body: some View {
        HStack {
            Text("Size: \(Int(selectedSore?.soreSize.last ?? 3)) mm")
            Slider(value: Binding(
                get: { self.selectedSore?.soreSize.last ?? 3 },
                set: { newValue in
                    if var sore = self.selectedSore {
                        sore.soreSize[sore.soreSize.count - 1] = newValue
                        self.selectedSore = sore
                    }
                }
            ), in: 0...20, step: 1)
            .disabled(selectedSore == nil)
        }
    }
}

struct PainScoreSlider: View { 
    @Binding var selectedSore: CankerSore?
    
    var body: some View {
        HStack {
            Text("Pain: \(Int(selectedSore?.painLevel.last ?? 3))")
            Slider(value: Binding(
                get: { self.selectedSore?.painLevel.last ?? 3 },
                set: { newValue in
                    if var sore = self.selectedSore {
                        sore.painLevel[sore.painLevel.count - 1] = newValue
                        self.selectedSore = sore
                    }
                }
            ), in: 0...10, step: 1)
            .disabled(selectedSore == nil)
        }
    }
}
