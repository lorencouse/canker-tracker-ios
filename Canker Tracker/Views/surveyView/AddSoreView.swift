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
    @State private var selectedSore: CankerSore? = nil
    @State var soreLogUptoDate: Bool
    
    
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
                            DrawZoomedSoreCircle(selectedSore: selectedSore!)
                        }
                        
                    }
                    
                }
                .frame(width: Constants.diagramWidth, height: Constants.diagramHeight)
                
                
            }
            
            VStack {
                soreLocationText
                SoreSizeSlider(selectedSore: $selectedSore)
                PainScoreSlider(selectedSore: $selectedSore)
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
                selectedSore = CankerSoreManager.initializeNewCankerSore(xCoordinateZoomed: value.location.x, yCoordinateZoomed: value.location.y, imageLocation: imageName)
            }
    }
    
    var soreLocationText: some View {
        Group {
            Text("Tap Sore Location")
                .font(.title2)
            Text("X:\(selectedLocationX ?? 0) Y:\(selectedLocationY ?? 0)")
        }
    }
    
//    var soreSizeSlider: some View {
//        HStack {
//            Text("Size: \(Int(selectedSore?.soreSize.last ?? 3)) mm")
//            
//            Slider(value: Binding(
//                get: { selectedSore?.soreSize.last ?? 3 },
//                set: { newValue in
//                    if selectedSore != nil {
//                        selectedSore!.soreSize[selectedSore!.soreSize.count - 1] = newValue
//                    }
//                }   
//            ), in: 0...20, step: 1)
//        }
//        
//        
//
//    }
//    
//    var painScoreSlider: some View {
//        
//        HStack {
//            Text("Pain: \(Int(selectedSore?.painLevel.last ?? 3))")
//            Slider(value: Binding(
//                get: { selectedSore?.painLevel.last ?? 3 },
//                set: { newValue in
//                    if selectedSore != nil {
//                        selectedSore!.painLevel[selectedSore!.painLevel.count - 1] = newValue
//                    }
//                }
//            ), in: 0...10, step: 1)
//            
//        }
//        
//
//    }
    
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
                
                CankerSoreManager.saveNewCankerSore(newCankerSore: selectedSore)
                
                                if soreLogUptoDate {
                                    navigateTo = "MainMouthView"
                                } else {
                                    navigateTo = "DailyLogView"
                                }
                
                
            }
            .disabled(selectedLocationX == nil)
            
            
            CustomButton(buttonLabel: "Add More") {
                CankerSoreManager.saveNewCankerSore(newCankerSore: selectedSore)
                navigateTo = "SelectMouthZonesView"
                
            }
            
        }
    }
}

#Preview {
    AddSoreView(imageName: "leftCheek", soreLogUptoDate: true)
}
