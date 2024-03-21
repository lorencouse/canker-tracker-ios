////
////  SoreHistoryView.swift
////  Canker Tracker
////
////  Created by Loren Couse on 2024/3/3.
////
//
//import Foundation
//import SwiftUI
//
//struct OldMouthMainView: View {
//    @State var soresList: [CankerSore] = []
//    @State var lastLog: DailyLog? = nil
//    @State private var selectedSore: CankerSore?
//    @State var soreLogUptoDate: Bool = false
//    @State var isEditing: Bool
//    @State var addNew: Bool
//    @State var locationIsSelected: Bool = false
//    @State private var selectedX: Double? = nil
//    @State private var selectedY: Double? = nil
//    @State private var circleOutlineColor: Color = Color.black
//    @State var selectedZone: String = "none"
//    @State var imageName: String = "mouthDiagramNoLabels"
//    @State var headerText: String = "Canker Sore History"
//    let diagramHeight: Double = Constants.diagramHeight
//    
//    var body: some View {
//        NavigationStack {
//            VStack {
//                
//                Spacer()
//                Text(headerText)
//                    .font(.title)
//                
//                Spacer()
//                
//                ZStack(alignment: .topLeading) {
//                    Image(imageName)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: diagramHeight, height: diagramHeight)
//                        .contentShape(Rectangle())
//                        .edgesIgnoringSafeArea(.all)
//                        .gesture(
//                            DragGesture(minimumDistance: 0)
//                                .onEnded { value in
//                                    let location = value.location
//                                    if addNew || isEditing {
//                                        selectedZone = TapManager.selectMouthZone(at: location)
//                                        locationIsSelected = true
//
//                                    } else {
////                                        drawExistingSore(sore: TapManager.findNearestSore(to: location, from: soresList)!, circleOutlineColor: Color.red)
//                                    }
//                                }
//                        )
//                    
//                    ForEach(soresList, id:\.self) {
//                        sore in
////                        drawExistingSore(sore: sore, circleOutlineColor: Color.black)
//                        DrawZoomedSoreCircle(selectedSore: sore, outlineColor: .black, sizeMultiplyer: 1)
//                        
//                    }
//                    
//                }
//                .frame(width: diagramHeight, height: diagramHeight)
//                
//                Spacer()
//                
//                HStack {
//                    CustomButton(buttonLabel: "Clear") {
//                        
//                        resetAppData()
//                        
//                    }
//                    CustomButton(buttonLabel: "Edit Mode") {
//                        isEditing.toggle()
//                        if isEditing && addNew {
//                            addNew.toggle()
//                        }
//                        if isEditing {imageName = "mouthDiagramNoLabels"
//                            headerText = "Edit Mode"}
//                    }
//                    
//                }
//                
//                HStack {
//                    CustomButton(buttonLabel: "Add Mode") {
//                        addNew.toggle()
//                        if isEditing && addNew {
//                            isEditing.toggle()
//                        }
//                        if addNew {imageName = "mouthDiagram"
//                        headerText = "Add New Sore"} else {imageName = "mouthDiagramNoLabels"}
//
//                    }
//
//                    NavigationButton(destination: DailyLogView(), label: "Survey")
//                }
//                    
//                NavigationLink("", destination: AddSoreView(imageName: selectedZone, soreLogUptoDate: soreLogUptoDate), isActive: $locationIsSelected)
//                
//            }
//        }
//        .onAppear {
////            if addNew {
////                imageName = "mouthDiagram"
////            }
//            lastLog = DailyLogManager.loadLastLog()
//            soreLogUptoDate = DailyLogManager.checkIfDailyLogUpToDate(lastLog: lastLog)
//            soresList = CankerSoreManager.loadActiveSores(imageName: nil)
//
//        }
//        
//    }
//    
//    private func resetAppData() {
//        
//        AppDataManager.deleteJsonData(fileName: Constants.dailyLogFileName)
//        AppDataManager.deleteJsonData(fileName: Constants.soreDataFileName)
//        soresList = []
//        soreLogUptoDate = false
//
//    }
//    
//}
//
//
//
//
//
//#Preview {
//    OldMouthMainView(soresList: [], isEditing: false, addNew: false)
//}
