//
//  RefactoredSoreLocationView.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/3/5.
//

import Foundation
import SwiftUI

struct SoreLocationView: View {
    let imageName: String
    @ObservedObject var viewModel: SoreViewModel
    @State var isEditing: Bool
    @State var addMoreSores: Bool = false
    @State var finishedAdding: Bool = false
    @State private var selectedLocationX: Double? = nil
    @State private var selectedLocationY: Double? = nil
    @State private var soreSize: Double = 3
    @State private var painScore: Double = 3
    @State private var circleOutlineColor: Color = Color.black
    
    var body: some View {
        VStack {
            Text(Constants.imageScaleValues[imageName]?.viewName ?? "")
                .font(.title)
                .multilineTextAlignment(.center)
                .fixedSize()
            
            GeometryReader { geometry in
                ZStack(alignment: .topLeading) {
                    
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: Constants.diagramWidth, height: Constants.diagramHeight)
                        .contentShape(Rectangle())
                        .edgesIgnoringSafeArea(.all)
                    
                    if isEditing {
                        soreButtons
                    }
                    
                    
                    Color.clear
                        .contentShape(Rectangle())
                        .gesture(dragGesture)
                    
                    
                    if let x = selectedLocationX, let y = selectedLocationY {
                        Circle()
                            .fill(Constants.painScaleColors[Int(painScore)])
                            .stroke(circleOutlineColor, lineWidth: 1)
                            .frame(width: soreSize * 2, height: soreSize * 2)
                            .offset(x: x - soreSize, y: y - soreSize)
                    }
                    
                }
                
            }
            .frame(width: Constants.diagramWidth, height: Constants.diagramHeight)
            
            soreLocationText
            soreSizeSlider
            painScoreSlider
            actionButtons
        }
        navigationLinks
        .onAppear {             if isEditing {
            viewModel.loadExistingSores(for: imageName)
        } }
    }
    
    
    


    
}

private extension SoreLocationView {
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onEnded { value in
                let location = CGPoint(x: value.location.x, y: value.location.y)
                if isEditing {
                    selectNearestSore(to: location)
                } else {
                    self.selectedLocationX = Double(location.x)
                    self.selectedLocationY = Double(location.y)
                }
            }
    }
    
    var soreButtons: some View {
        ForEach(viewModel.sores, id: \.self) { sore in
            Button(action: { selectSore(sore) }) {
                SoreObjectView(sore: sore)
            }
        }
    }
    
    var soreLocationText: some View {
        Group {
            Text("Tap Sore Location")
                .font(.title2)
            Text("X:\(selectedLocationX ?? 0) Y:\(selectedLocationY ?? 0)")
        }
    }
    
    var soreSizeSlider: some View {
        HStack {
            Text("Sore Size: \(Int(soreSize)) mm")
            Slider(value: $soreSize, in: 1...20, step: 1)
                .padding()
                .disabled(selectedLocationX == nil)
        }
        .padding(.leading)
    }
    
    var painScoreSlider: some View {
        HStack {
            Text("Pain Score: \(Int(painScore))")
            Slider(value: $painScore, in: 0...10, step: 1)
                .padding()
                .disabled(selectedLocationX == nil)
        }
        .padding(.leading)
    }
    
    var actionButtons: some View {
        HStack {
            CustomButton(buttonLabel: "Finish") {
                saveCankerSore()
                finishedAdding = true
            }
                .disabled(selectedLocationX == nil)
            
            CustomButton(buttonLabel: isEditing ? "Update" : "Add More", action: addOrUpdateSore)
        }
    }
    
    var navigationLinks: some View {
        Group {
            NavigationLink(destination: MouthDiagramView(), isActive: $addMoreSores) { EmptyView() }
            NavigationLink(destination: SoreHistoryView(isEditing: isEditing), isActive: $finishedAdding) { EmptyView() }
        }
    }
    
    // Additional helper methods if needed
    func selectSore(_ sore: CankerSore) {
        viewModel.selectedSore = sore
        selectedLocationX = sore.xCoordinateZoomed
        selectedLocationY = sore.yCoordinateZoomed
        soreSize = sore.size.last ?? 3
        painScore = sore.painLevel.last ?? 3
    }
    
    private func saveCankerSore() {
        
        let imageScale = Constants.imageScaleValues
        if let x = selectedLocationX, let y = selectedLocationY {
            
            let xScaled = (x * imageScale[imageName]!.scaleX) + imageScale[imageName]!.xOffset
            let yScaled = (y * imageScale[imageName]!.scaleY) + imageScale[imageName]!.yOffset
            
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
                xCoordinate: xScaled,
                yCoordinate: yScaled
            )
            AppDataManager.shared.appendCankerSoreData(newCankerSore)
        }
    }
    
    func addOrUpdateSore() {
        if isEditing, let sore = viewModel.selectedSore {
            viewModel.updateCankerSore(sore, newSize: soreSize, newPain: painScore)
        } else {
            saveCankerSore()
            addMoreSores = true
        }
    }
    
    func selectNearestSore(to location: CGPoint) {
        guard let closestSore = viewModel.sores.min(by: {
            let distance1 = distance(from: CGPoint(x: $0.xCoordinate, y: $0.yCoordinate), to: location)
            let distance2 = distance(from: CGPoint(x: $1.xCoordinate, y: $1.yCoordinate), to: location)
            return distance1 < distance2
        }) else { return }
        
        // Update selectedSore and associated state
        viewModel.selectedSore = closestSore
        selectedLocationX = closestSore.xCoordinate
        selectedLocationY = closestSore.yCoordinate
        soreSize = closestSore.size.last ?? 3
        painScore = closestSore.painLevel.last ?? 3
        circleOutlineColor = Color.red
    }

    func distance(from point1: CGPoint, to point2: CGPoint) -> CGFloat {
        return sqrt(pow(point2.x - point1.x, 2) + pow(point2.y - point1.y, 2))
    }

}
