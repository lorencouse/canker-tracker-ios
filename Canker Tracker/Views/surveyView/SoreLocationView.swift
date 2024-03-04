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
    @ObservedObject var viewModel: SoreViewModel = SoreViewModel()
    @State var isEditing: Bool
    @State var addMoreSores: Bool = false
    @State var finishedAdding: Bool = false
    @State private var selectedLocationX: Double? = nil
    @State private var selectedLocationY: Double? = nil
    @State private var diagramWidth: Double = Constants.diagramWidth
    @State private var diagramHeight: Double = Constants.diagramHeight
    @State private var soreSize: Double = 3
    @State private var painScore: Double = 3
    
    var body: some View {
        
        VStack {
            
            Text("\(Constants.imageScaleValues[imageName]?.viewName ?? "")")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            
            
            
            GeometryReader { geometry in
                ZStack(alignment: .topLeading) {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: diagramWidth, height: diagramHeight)
                        .contentShape(Rectangle())
                        .edgesIgnoringSafeArea(.all)
                    
                    if isEditing {
                        ForEach(viewModel.sores, id: \.self) { sore in
                            Button(action: {
                                // Logic to select this sore for editing
                                viewModel.selectedSore = sore
                                selectedLocationX = sore.xCoordinateZoomed
                                selectedLocationY = sore.yCoordinateZoomed
                                soreSize = sore.size.last ?? 3
                                painScore = sore.painLevel.last ?? 3
                            }) {
                                SoreObjectView(sore: sore)
                            }
                        }
                    }
                    
                    Color.clear
                        .contentShape(Rectangle())
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onEnded { value in
                                    self.selectedLocationX = Double(value.location.x)
                                    self.selectedLocationY = Double(value.location.y)
                                }
                        )
                    
                    if let x = selectedLocationX, let y = selectedLocationY {
                        Circle()
                            .fill(Constants.painScaleColors[Int(painScore)])
                            .stroke(Color.black, lineWidth: 1)
                            .frame(width: soreSize * 2, height: soreSize * 2)
                            .offset(x: x - soreSize, y: y - soreSize)
                    }
                }
            }
            .frame(width: diagramWidth, height: diagramHeight)
            
            
            
            
            
            
            Text("Tap Sore Location")
                .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
            
            Text("X:\(selectedLocationX ?? 0) Y:\(selectedLocationY ?? 0) ")
            
            HStack {
                Text("Sore Size: \(Int(soreSize)) mm")
                Slider(value: $soreSize, in: 1...20, step: 1)
                    .padding()
                    .disabled(selectedLocationX == nil || selectedLocationY == nil)
            }
            .padding(.leading)
            
            HStack {
                Text("Pain Score: \(Int(painScore))     ")
                Slider(value: $painScore, in: 0...10, step: 1)
                    .padding()
                    .disabled(selectedLocationX == nil || selectedLocationY == nil)
            }
            .padding(.leading)
            
            
            
            HStack {
                
                
                CustomButton(buttonLabel: "Finish") {
                    saveCankerSore()
                    finishedAdding = true
                }
                .disabled(selectedLocationX == nil || selectedLocationY == nil)
                
                CustomButton(buttonLabel: isEditing ? "Update" : "Add More") {
                    if isEditing {
                        if let sore = viewModel.selectedSore {
                            viewModel.updateCankerSore(sore, newSize: soreSize, newPain: painScore)
                        }
                    } else {
                        saveCankerSore()
                    }
                }
                
                
            }
            
            NavigationLink(destination: MouthDiagramView(), isActive: $addMoreSores) { EmptyView() }
            NavigationLink(destination: SoreHistoryView(isEditing: isEditing), isActive: $finishedAdding) { EmptyView() }
            
            

            
        }
        
        .onAppear {
            if isEditing {
                viewModel.loadExistingSores(for: imageName)
            }
        }
        
        
    }
    
    
    
    private func saveCankerSore() {
        
        let imageScale = Constants.imageScaleValues
        if let x = selectedLocationX, let y = selectedLocationY {
            
            let xZoomed = (x * imageScale[imageName]!.scaleX) + imageScale[imageName]!.xOffset
            let yZoomed = (y * imageScale[imageName]!.scaleY) + imageScale[imageName]!.yOffset
            
            let newCankerSore = CankerSore(
                id: UUID(),
                lastUpdated: [Date()],
                numberOfDays: 1,
                healed: false,
                location: imageName,
                size: [soreSize],
                painLevel: [painScore],
                xCoordinateZoomed: x,
                yCoordinateZoomed: y,
                xCoordinate: xZoomed,
                yCoordinate: yZoomed
            )
            AppDataManager.shared.saveCankerSoreData(newCankerSore)
        }
    }
}


#Preview {
    SoreLocationView( imageName: "leftCheek", isEditing: false)
}


