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
    var soreLogUptoDate: Bool
    let soreID = UUID()
    @State var isEditing: Bool
    @State private var selectedSore: CankerSore?
    @State private var existingSores: [CankerSore] = []
    @State private var addMoreSores: Bool = false
    @State private var navigateTo: String?
    @State private var healedFilter: Bool = false
    @State private var selectedLocationX: Double? = nil
    @State private var selectedLocationY: Double? = nil
    @State private var soreSize: Double = 3
    @State private var painLevel: Double = 3
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
                            .fill(Constants.painScaleColors[Int(painLevel)])
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
            
            if isEditing {
                filterToggles
            }
            
            actionButtons
        }
        navigationLinks
            .onAppear {             if isEditing {
                loadSoresForDiagram(for: imageName)
            }
//             soreLogUptoDate =   DailyLogManager.checkIfDailyLogUpToDate(lastLog: DailyLogManager.loadLastLog())
            }
    }
    
    func loadSoresForDiagram(for imageName: String) {
        let allSores = AppDataManager.loadJsonData(fileName: Constants.soreDataFileName, type: [CankerSore].self) ?? []
        existingSores = allSores.filter { sore in
            sore.locationImage == imageName
        }
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
    
    var filterToggles: some View {
        
        HStack {
        Text("Show:")
            
            Spacer()
            
            Picker("", selection: $healedFilter) {
                Text("Past").tag(true)
                
                Text("Current").tag(false)
                soreButtons
            }.pickerStyle(SegmentedPickerStyle())
        
        }

        
    }
    
    var soreButtons: some View {
        ForEach(existingSores, id: \.self) { sore in
            
            if healedFilter {
                if sore.healed {
                    
                    Button(action: { selectSore(sore) }) {
                        SoreObjectView(sore: sore)
                        
                }
            }
            
            }
            
            else {
                Button(action: { selectSore(sore) }) {
                    SoreObjectView(sore: sore)
                }
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
            Text("Sore Size: \(soreSize != 0 ? "\(Int(soreSize)) mm" : "Healed" )")
            Slider(value: $soreSize, in: 0...20, step: 1)
                .padding()
                .disabled(selectedLocationX == nil)
        }
        .padding(.leading)
    }
    
    var painScoreSlider: some View {
        HStack {
            Text("Pain Score: \(soreSize != 0 ? "\(Int(painLevel))" : "Healed" )")
            Slider(value: $painLevel, in: 0...10, step: 1)
                .padding()
                .disabled(selectedLocationX == nil)
        }
        .padding(.leading)
    }
    
    var actionButtons: some View {
        HStack {
            CustomButton(buttonLabel: "Finish") {
                
                CankerSoreManager.saveNewCankerSore(id: soreID, lastUpdated: [Date()], numberOfDays: 1, healed: false, location: imageName, soreSize: soreSize, painLevel: painLevel, xCoordinateZoomed: selectedLocationX ?? 0, yCoordinateZoomed: selectedLocationY ?? 0)
                
                if soreLogUptoDate {
                    navigateTo = "SoreHistory"
                } else {
                    navigateTo = "DailyLog"
                }
            }
                .disabled(selectedLocationX == nil)
            
            if isEditing {
                CustomButton(buttonLabel:"Update") {

                }
            }
            else {
                CustomButton(buttonLabel: "Add More") {
                    CankerSoreManager.saveNewCankerSore(id: soreID, lastUpdated: [Date()], numberOfDays: 1, healed: false, location: imageName, soreSize: soreSize, painLevel: painLevel, xCoordinateZoomed: selectedLocationX ?? 0, yCoordinateZoomed: selectedLocationY ?? 0)
//                    saveNewCankerSore()
                    addMoreSores = true
                }
            }
            
        }
    }
    
    
    
    var navigationLinks: some View {
        Group {

            NavigationLink(destination:SoreHistoryView(isEditing: false, addNew: true), isActive: $addMoreSores) { EmptyView() }
            
            NavigationLink(destination: DailyLogView(), tag: "DailyLog", selection: $navigateTo) { EmptyView() }
            
            NavigationLink(destination: SoreHistoryView(isEditing: false, addNew: false), tag: "SoreHistory", selection: $navigateTo) { EmptyView() }

            

        }
    }
    
    func selectSore(_ sore: CankerSore) {
        selectedSore = sore
        selectedLocationX = sore.xCoordinateZoomed
        selectedLocationY = sore.yCoordinateZoomed
        soreSize = sore.soreSize.last ?? 3
        painLevel = sore.painLevel.last ?? 3
    }
    
    func selectNearestSore(to location: CGPoint) {
        guard let closestSore = existingSores.min(by: {
            let distance1 = distance(from: CGPoint(x: $0.xCoordinateScaled, y: $0.yCoordinateScaled), to: location)
            let distance2 = distance(from: CGPoint(x: $1.xCoordinateScaled, y: $1.yCoordinateScaled), to: location)
            return distance1 < distance2
        }) else { return }
        
        selectedSore = closestSore
        selectedLocationX = closestSore.xCoordinateScaled
        selectedLocationY = closestSore.yCoordinateScaled
        soreSize = closestSore.soreSize.last ?? 3
        painLevel = closestSore.painLevel.last ?? 3
        circleOutlineColor = Color.red
    }

    func distance(from point1: CGPoint, to point2: CGPoint) -> CGFloat {
        return sqrt(pow(point2.x - point1.x, 2) + pow(point2.y - point1.y, 2))
    }

}

#Preview {
    SoreLocationView(imageName: "leftCheek", soreLogUptoDate: true, isEditing: false)
}
