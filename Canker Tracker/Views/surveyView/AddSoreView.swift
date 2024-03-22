//
//  AddSoreView.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/3/16.
//

import Foundation
import SwiftUI

struct AddSoreView: View {
    let imageName: String
    @State private var navigateTo: String?
    @State private var selectedLocationX: Double? = nil
    @State private var selectedLocationY: Double? = nil
    @State private var selectedSore: CankerSore = CankerSoreManager.initializeNewCankerSore()
    @State var soreLogUptoDate: Bool
    @State private var tempSoreSize: Double = 3
    @State private var tempPainLevel: Double = 3
    
    
    var body: some View {
        
        
        
        ScrollView {
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
                        
                        Color.clear
                            .contentShape(Rectangle())
                            .gesture(dragGesture)
                        
                        if let x = selectedLocationX, let y = selectedLocationY {
                            DrawZoomedSoreCircle(selectedSore: selectedSore, outlineColor: .red)
                        }
                        
                    }
                    
                }
                .frame(width: Constants.diagramWidth, height: Constants.diagramHeight)
                
                
            }
            
            VStack {
                soreLocationText
                if selectedSore.soreSize != nil {
                    SoreSizeSlider(selectedSore: $selectedSore)
                    PainScoreSlider(selectedSore: $selectedSore)
                }

                actionButtons
                navigationLinks
            }
        }
        
    }
    
}
    


    


private extension AddSoreView {
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onEnded { value in
                let location = CGPoint(x: value.location.x, y: value.location.y)
                    self.selectedLocationX = Double(location.x)
                    self.selectedLocationY = Double(location.y)
                selectedSore = CankerSoreManager.initializeNewCankerSore()
            }
    }
    
    var soreLocationText: some View {
        Group {
            Text("Tap Sore Location")
                .font(.title2)
            Text("X:\(selectedLocationX ?? 0) Y:\(selectedLocationY ?? 0)")
        }
    }
    
    
    var navigationLinks: some View {
        Group {
            
            NavigationLink(destination: MainMouthView(), tag: "MainMouthView", selection: $navigateTo) { EmptyView() }
            
            NavigationLink(destination: SelectMouthZoneView( soreLogUptoDate: soreLogUptoDate), tag: "SelectMouthZonesView", selection: $navigateTo) { EmptyView() }
            
            NavigationLink(destination: DailyLogView(), tag: "DailyLogView", selection: $navigateTo) { EmptyView() }

        }
    }
    
    var actionButtons: some View {
        HStack {
            
            
            CustomButton(buttonLabel: "Finish") {
                
                CankerSoreManager.saveNewCankerSore(newCankerSore: selectedSore, imageLocation: imageName)
                
                                if soreLogUptoDate {
                                    navigateTo = "MainMouthView"
                                } else {
                                    navigateTo = "DailyLogView"
                                }
                
                
            }
            .disabled(selectedLocationX == nil)
            
            
            CustomButton(buttonLabel: "Add More") {
                CankerSoreManager.saveNewCankerSore(newCankerSore: selectedSore, imageLocation: imageName)
                navigateTo = "SelectMouthZonesView"
                
            }
            
        }
    }
}

#Preview {
    AddSoreView(imageName: "leftCheek", soreLogUptoDate: true)
}
