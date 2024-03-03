//
//  TongueView.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/2/28.
//

import Foundation
import SwiftUI

struct SoreLocationView: View {
    let imageName: String
    @State var addMoreSores: Bool = false
    @State var finishedAdding: Bool = false
    @State private var selectedLocation: CGPoint? = nil
    @State private var diagramWidth: CGFloat = 350
    @State private var diagramHeight: CGFloat = 350
    @State private var soreSize: CGFloat = 3
    @State private var painScore: CGFloat = 3
    let painScaleColors: [Color] = [
        Color.pain0,
        Color.pain1,
        Color.pain2,
        Color.pain3,
        Color.pain4,
        Color.pain5,
        Color.pain6,
        Color.pain7,
        Color.pain8,
        Color.pain9,
        Color.pain10
    ]
    
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
                            .fill(painScaleColors[Int(painScore)])
                            .stroke(Color.black, lineWidth: 1)
                            .frame(width: soreSize*2, height: soreSize*2)
                            .offset(x: selectedLocation.x - (soreSize), y: selectedLocation.y - (soreSize))
                    }
                }
            }
            .frame(width: diagramWidth, height: diagramHeight)
            
            
            Text("Sore Size: \(Int(soreSize)) mm")
            Slider(value: $soreSize, in: 1...20, step: 1)
                .padding()
                .disabled(selectedLocation == nil)
            
            Text("Pain Score: \(Int(painScore))")
            Slider(value: $painScore, in: 0...10, step: 1)
                .padding()
                .disabled(selectedLocation == nil)
            
            HStack {
                CustomButton(buttonLabel: "Finish") {
                    saveCankerSore()
                    finishedAdding = true
                }
                    .disabled(selectedLocation == nil)
                
                CustomButton(buttonLabel: "Add More") {
                    saveCankerSore()
                    addMoreSores = true
                }
                .disabled(selectedLocation == nil)
                
            }
            
            NavigationLink(destination: MouthDiagramView(), isActive: $addMoreSores) { EmptyView() }
            
            NavigationLink(destination: SoreHistoryView(), isActive: $finishedAdding) { EmptyView() }

        }
    }
    
    private func saveCankerSore() {
        let newCankerSore = CankerSore(
//                        id: Self.ID,
            startDate: Date(), heeled: false,
            numberOfDays: 1,
            location: imageName,
            size: [soreSize],
            painLevel: [painScore],
            coordinates: selectedLocation!
        )
        AppDataManager.shared.saveCankerSoreData(newCankerSore)
    }
    
    
    
}

#Preview {
    SoreLocationView( imageName: "Cheek")
}


