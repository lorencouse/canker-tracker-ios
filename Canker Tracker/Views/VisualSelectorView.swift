//
//  TongueView.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/2/28.
//

import Foundation
import SwiftUI

struct visualSelector: View {
    let imageName: String
    @State private var selectedLocation: CGPoint? = nil
    @State private var diagramWidth: CGFloat = 350 // Adjust as needed
    @State private var diagramHeight: CGFloat = 350 // Adjust as needed
    
    var body: some View {
        VStack {
            Text("Tap on the diagram to select a location.")
            if let selectedLocation = selectedLocation {
                Text("Selected Location: \(selectedLocation.debugDescription)")
            } else {
                Text("Selected Location: None")
            }
            
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
                                    // Calculate the tap location within the image
                                    let location = value.location
                                    // Adjust location based on image scaling and position
                                    self.selectedLocation = CGPoint(x: location.x, y: location.y)
                                }
                        )
                    
                    if let selectedLocation = selectedLocation {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 10, height: 10) // Dot size
                            .offset(x: selectedLocation.x - 10, y: selectedLocation.y - 10) // Center the dot
                    }
                }
            }
            .frame(width: diagramWidth, height: diagramHeight) // Specify the frame for GeometryReader
        }
    }
}


