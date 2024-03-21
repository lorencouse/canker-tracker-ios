////
////  RefactoredSoreLocationView.swift
////  Canker Tracker
////
////  Created by Loren Couse on 2024/3/5.
////
//
//import Foundation
//import SwiftUI
//
//struct OldAddSoreView: View {
//    let imageName: String
//    var soreLogUptoDate: Bool
//    @State var isEditing: Bool
//    @State private var selectedSore: CankerSore?
//    @State private var soresList: [CankerSore] = []
//    @State private var addMoreSores: Bool = false
//    @State private var navigateTo: String?
//    @State private var healedFilter: Bool = false
//    @State private var selectedLocationX: Double? = nil
//    @State private var selectedLocationY: Double? = nil
//    @State private var circleOutlineColor: Color = Color.black
//
//    
//    var body: some View {
//        
//        ScrollView {
//            VStack {
//                
//                Text(Constants.imageScaleValues[imageName]?.viewName ?? "")
//                    .font(.title)
//                    .multilineTextAlignment(.center)
//                    .fixedSize()
//                
//                GeometryReader { geometry in
//                    ZStack(alignment: .topLeading) {
//                        
//                        Image(imageName)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: Constants.diagramWidth, height: Constants.diagramHeight)
//                            .contentShape(Rectangle())
//                            .edgesIgnoringSafeArea(.all)
//                    
//                        
//                        
//                        Color.clear
//                            .contentShape(Rectangle())
//                            .gesture(dragGesture)
//                        
//                        if let x = selectedLocationX, let y = selectedLocationY {
//                            if let sore = selectedSore, !isEditing {
//                                DrawZoomedSoreCircle(selectedSore: sore, outlineColor: .black)
//                            }
//                        }
//                        
//                    }
//                    
//                }
//                .frame(width: Constants.diagramWidth, height: Constants.diagramHeight)
//                
//
//            }
//            VStack {
//                soreLocationText
//                soreSizeSlider
//                painScoreSlider
//                actionButtons
//            }
//        }
//
////        navigationLinks
//            .onAppear {  if isEditing {
//               soresList = CankerSoreManager.loadActiveSores(imageName: imageName)
//                if isEditing {
//                    selectedSore = soresList.first
//                }
//                
//            }
//
//            }
//    }
//    
//
//
//    
//}
//
//private extension OldAddSoreView {
//    
//    var dragGesture: some Gesture {
//        DragGesture(minimumDistance: 0)
//            .onEnded { value in
//                let location = CGPoint(x: value.location.x, y: value.location.y)
//
//                if isEditing {
//                    if let nearestSore = TapManager.findNearestZoomedSore(to: location, from: soresList) {
//                        selectedSore = nearestSore
//                        circleOutlineColor = .red // Highlight the selected sore
//                    }
//                } else {
//                    self.selectedLocationX = Double(location.x)
//                    self.selectedLocationY = Double(location.y)
//                }
//            }
//    }
//
//    
//    var soreLocationText: some View {
//        Group {
//            Text("Tap Sore Location")
//                .font(.title2)
//            Text("X:\(selectedLocationX ?? 0) Y:\(selectedLocationY ?? 0)")
//        }
//    }
//    
//    var soreSizeSlider: some View {
//        Slider(value: Binding(
//            get: { selectedSore?.soreSize.last ?? 3 },
//            set: { newValue in
//                if selectedSore != nil {
//                    selectedSore!.soreSize[selectedSore!.soreSize.count - 1] = newValue
//                }
//            }
//        ), in: 0...20, step: 1)
//    }
//    
//    var painScoreSlider: some View {
//        Slider(value: Binding(
//            get: { selectedSore?.painLevel.last ?? 3 },
//            set: { newValue in
//                if selectedSore != nil {
//                    selectedSore!.painLevel[selectedSore!.painLevel.count - 1] = newValue
//                }
//            }
//        ), in: 0...10, step: 1)
//    }
//    
//    var actionButtons: some View {
//        HStack {
//            CustomButton(buttonLabel: "Finish") {
//                
//                CankerSoreManager.saveNewCankerSore(newCankerSore: selectedSore)
//                
////                if soreLogUptoDate {
////                    navigateTo = "SoreHistory"
////                } else {
////                    navigateTo = "DailyLog"
////                }
//                navigateTo = "SoreHistory"
//                
//            }
//                .disabled(selectedLocationX == nil)
//            
//
//                CustomButton(buttonLabel: "Add More") {
//                    CankerSoreManager.saveNewCankerSore(newCankerSore: selectedSore)
//                        navigateTo = "SelectMouthZones"
//                
//            }
//            
//        }
//    }
//    
//    
//    
//    var navigationLinks: some View {
//        Group {
//
////            NavigationLink(destination:MainMouthView()) { EmptyView() }
//            
////            NavigationLink(destination: DailyLogView(), tag: "DailyLog", selection: $navigateTo) { EmptyView() }
////            
////            NavigationLink(destination: MainMouthView(isEditing: false, addNew: false), tag: "SoreHistory", selection: $navigateTo) { EmptyView() }
//
//        }
//    }
//    
////    func selectSore(_ sore: CankerSore) {
////        selectedSore = sore
////        selectedLocationX = sore.xCoordinateZoomed
////        selectedLocationY = sore.yCoordinateZoomed
////        soreSize = sore.soreSize.last ?? 3
////        painLevel = sore.painLevel.last ?? 3
////        circleOutlineColor = Color.red
////    }
//    
////    func selectNearestSore(to location: CGPoint) -> CankerSore? {
////        let closestSore = existingSores.min(by: { sore1, sore2 in
////            let distance1 = distance(from: CGPoint(x: sore1.xCoordinateZoomed, y: sore1.yCoordinateZoomed), to: location)
////            let distance2 = distance(from: CGPoint(x: sore2.xCoordinateZoomed, y: sore2.yCoordinateZoomed), to: location)
////            return distance1 < distance2
////        })
////        
////        return closestSore
//        
////        selectedSore = closestSore
////        selectedLocationX = closestSore.xCoordinateZoomed
////        selectedLocationY = closestSore.yCoordinateZoomed
////        soreSize = closestSore.soreSize.last ?? 3
////        painLevel = closestSore.painLevel.last ?? 3
////        circleOutlineColor = Color.red
//    }
//
////    func distance(from point1: CGPoint, to point2: CGPoint) -> CGFloat {
////        return sqrt(pow(point2.x - point1.x, 2) + pow(point2.y - point1.y, 2))
////    }
//
////}
//
//#Preview {
//    OldAddSoreView(imageName: "leftCheek", soreLogUptoDate: true, isEditing: false)
//}
