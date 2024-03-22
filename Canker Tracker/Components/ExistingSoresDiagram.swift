//
//  ExistingSoresDiagram.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/3/21.
//

import Foundation
import SwiftUI

struct ExistingSoresDiagram: View {
    
    let diagramSize: Double = Constants.diagramHeight
    let soresList: [CankerSore]
    let diagramName: String
    let zoomedView: Bool
    @Binding var selectedSore: CankerSore
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image(diagramName)
                .resizable()
                .scaledToFit()
                .frame(width: diagramSize, height: diagramSize)
                .contentShape(Rectangle())
                .edgesIgnoringSafeArea(.all)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                        }
                        .onEnded { value in
                            let location = value.location
                            if let nearestSore = TapManager.findNearestScaledSore(to: location, from: soresList) {
                                selectedSore = nearestSore
                            }
                        }
                    )
            

            
            if zoomedView {

                if let x = selectedSore.xCoordinateZoomed, let y = selectedSore.xCoordinateZoomed {
                    RenderZoomedSoresList(soresList: soresList, selectedSore: selectedSore)
                    DrawZoomedSoreCircle(selectedSore: selectedSore, outlineColor: .red)
                }

            } else {
                RenderScaledSoresList(soresList: soresList, selectedSore: selectedSore)

            }
            
            
        }
        .frame(width: diagramSize, height: diagramSize)
    }
    

}

struct RenderScaledSoresList: View {
    
    var soresList: [CankerSore]
    var selectedSore: CankerSore?
    
    var body: some View {
        ForEach(soresList, id:\.self) {
            sore in
            if sore.id == selectedSore?.id {
                DrawScaledSoreCircle(selectedSore: sore, outlineColor: .red)

            } else {
                
                DrawScaledSoreCircle(selectedSore: sore, outlineColor: .white)

            }
            
        }
    }
}

struct RenderZoomedSoresList: View {
    
    var soresList: [CankerSore]
    var selectedSore: CankerSore?
    
    var body: some View {
        ForEach(soresList, id:\.self) {
            sore in
            if sore.id == selectedSore?.id {
                DrawZoomedSoreCircle(selectedSore: sore, outlineColor: .red)

            } else {
                
                DrawZoomedSoreCircle(selectedSore: sore, outlineColor: .white)

            }
            
        }
    }
}
