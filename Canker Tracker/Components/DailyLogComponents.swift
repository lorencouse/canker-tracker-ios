//
//  SurveyComponents.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/3/4.
//

import Foundation
import SwiftUI

struct CustomToggle: View {
    @Binding var boolVariable: Bool
    let labelText: String
    
    var body: some View {
        
        Section {
            HStack {
                Text(labelText)
                Spacer()
                Picker("", selection: $boolVariable) {
                    Text("Yes").tag(true)
                    Text("No").tag(false)
                }.pickerStyle(SegmentedPickerStyle()).frame(width: 100)
            }

        }
        

    }
}


struct CustomNumberInput: View {
    @Binding var numberSelected: Int
    let labelText: String
    
    var body: some View {
        
        Section {
            HStack {
                Text(labelText)
                Spacer()
                Picker("", selection: $numberSelected) {
                    ForEach(0..<11) { number in
                        Text("\(number)").tag(number)
                    }
                }
                .pickerStyle(.menu)
                .frame(width: 100)
            }
        }
        

    }
}
