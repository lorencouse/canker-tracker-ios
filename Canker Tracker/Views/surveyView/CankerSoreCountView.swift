//
//  cankerSoreCount.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/2/29.
//

import Foundation
import SwiftUI

struct CankerSoreCountView: View {
    
    @State private var cankerCount: Int = 0;
    
    var body: some View {
        
        NavigationView {
            
            
            
            VStack {
                Spacer()
                Text("How many cankersores do you have today?")
                    .padding()
                Spacer()
                Picker("Number of canker sores", selection: $cankerCount) {
                    ForEach(0..<20) {
                        Text("\($0) sores")
                    }
                }
                .pickerStyle(.wheel)
                .padding()
                
                if cankerCount == 0 {
                    NavigationButton(destination: ContentView(), label: "Next")
                }
                
                else {
                    NavigationButton(destination: MouthDiagramView(), label: "Next")
                }
                
                
                
                
            }
            
        }
        
        
    }
    
}

#Preview {
    CankerSoreCountView()
}
