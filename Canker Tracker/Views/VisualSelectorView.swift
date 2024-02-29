//
//  TongueView.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/2/28.
//

import Foundation
import SwiftUI

struct VisualSelectorView: View {
    let imageName: String
    @State private var selectedLocation: CGPoint? = nil
    @State private var diagramWidth: CGFloat = 350
    @State private var diagramHeight: CGFloat = 350
    @State private var soreSize: CGFloat = 10
    
    var body: some View {
        
        
        VStack {
            Spacer()
            
            Text("Tap on image to select sore location")
            
            
            Spacer()
            
            GeometryReader { geometry in
                ZStack(alignment: .topLeading) {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: diagramWidth, height: diagramHeight)
                        .contentShape(Rectangle())
                    
                    Color.clear
                        .contentShape(Rectangle())
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onEnded { value in
                                    let location = value.location
                                    self.selectedLocation = CGPoint(x: location.x, y: location.y)
                                }
                        )
                    
                    if let selectedLocation = selectedLocation {
                        Circle()
                            .fill(Color.white)
                            .stroke(Color.black, lineWidth: 1)
                            .frame(width: soreSize, height: soreSize)
                            .offset(x: selectedLocation.x - (soreSize/2), y: selectedLocation.y - (soreSize/2))
                    }
                }
            }
            .frame(width: diagramWidth, height: diagramHeight)
            
            
            Text("Sore Size: \(Int(soreSize)) mm")
            Slider(value: $soreSize, in: 1...30, step: 1)
                .padding()
            if selectedLocation == nil {
                
                GreyedOutButton()
                
            }
            else {
                
                NavigationButton(destination: CankerLocationView(), label: "Next")
                
            }
            
        }
    }
    
    
    
}

#Preview {
    VisualSelectorView(imageName: "Cheek")
}


