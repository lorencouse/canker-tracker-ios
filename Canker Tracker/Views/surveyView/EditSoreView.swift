//
//  EditSoreView.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/3/16.
//

import Foundation
import SwiftUI

struct EditSoreView: View {
    let imageName: String
    @State var soreLogUptoDate: Bool
    @State private var selectedSore: CankerSore?
    @State private var soresList: [CankerSore] = []
    @State private var navigateTo: String?
    @State private var selectedLocationX: Double? = nil
    @State private var selectedLocationY: Double? = nil
    @State private var circleOutlineColor: Color = Color.black

    
    var body: some View {
        
        ScrollView {
            VStack {
                
                Text(Constants.imageScaleValues[imageName]?.viewName ?? "")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .fixedSize()
                
                ExistingSoresDiagram(soresList: soresList, diagramName: imageName, selectedSore: $selectedSore)
                

            }
            VStack {
                soreLocationText
                SoreSizeSlider(selectedSore: $selectedSore)
                PainScoreSlider(selectedSore: $selectedSore)
                actionButtons
            }
        }

//        navigationLinks
            .onAppear {
               soresList = CankerSoreManager.loadActiveSores(imageName: imageName)
                selectedSore = soresList.first
                createNewDaySoreValues()
            }
        
        
        
    }
    
    private func createNewDaySoreValues() {
        guard !soreLogUptoDate else { return }
        
        soresList = soresList.map { sore in
            var updatedSore = sore
            let newSoreSize = sore.soreSize.last
            let newPainLevel = sore.painLevel.last
            
            updatedSore.soreSize.append(newSoreSize ?? 3)
            updatedSore.painLevel.append(newPainLevel ?? 3)
            return updatedSore
        }
    }
    
}

private extension EditSoreView {
    
    var nearestSoreGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onEnded { value in
                let location = CGPoint(x: value.location.x, y: value.location.y)
                if let nearestSore = TapManager.findNearestZoomedSore(to: location, from: soresList) {
                    selectedSore = nearestSore
                    circleOutlineColor = .red
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
    
    var actionButtons: some View {
        HStack {
            CustomButton(buttonLabel: "Finish") {
                
                CankerSoreManager.overwriteSoreData(selectedSore)
                navigateTo = "SoreHistory"
                
            }
            .disabled(selectedLocationX == nil)
            
        }
    }
    
    
    
    var navigationLinks: some View {
        Group {
            
            //            NavigationLink(destination:MainMouthView()) { EmptyView() }
            
            //            NavigationLink(destination: DailyLogView(), tag: "DailyLog", selection: $navigateTo) { EmptyView() }
            //
            //            NavigationLink(destination: MainMouthView(isEditing: false, addNew: false), tag: "SoreHistory", selection: $navigateTo) { EmptyView() }
            
        }
    }
    
}

#Preview {
    EditSoreView(imageName: "leftCheek", soreLogUptoDate: true)
}
