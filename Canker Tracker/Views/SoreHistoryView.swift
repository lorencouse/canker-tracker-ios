//
//  SoreHistoryView.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/3/3.
//

import Foundation
import SwiftUI

struct SoreHistoryView: View {
    @State var isEditing: Bool
    @State var addNew: Bool
    @State var locationIsSelected: Bool = false
    @State var selectedLocation: String = "none"
    @State var imageName: String = "mouthDiagramNoLabels"
    @State var soresHistory: [CankerSore] = []
    @State var lastLog: DailyLog? = nil
    @State var headerText: String = "Canker Sore History"
    let diagramHeight: Double = Constants.diagramHeight
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()
                Text(headerText)
                    .font(.title)
                
                Spacer()
                
                ZStack(alignment: .topLeading) {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: diagramHeight, height: diagramHeight)
                        .contentShape(Rectangle())
                        .edgesIgnoringSafeArea(.all)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onEnded { value in
                                    let location = value.location
                                    if addNew || isEditing {
                                        selectedLocation = selectLocation(at: location)
                                        locationIsSelected = true

                                    }
                                }
                        )
                    
                    ForEach(soresHistory, id:\.self) {
                        sore in
                        SoreObjectView(sore: sore)
                        
                        
                    }
                    
                }
                .frame(width: diagramHeight, height: diagramHeight)
                
                Spacer()
                
                HStack {
                    CustomButton(buttonLabel: "Clear") {
                        AppDataManager.deleteJsonData(fileName: Constants.soreDataFileName)
                        fetchSoreHistory()
                    }
                    CustomButton(buttonLabel: "Edit Mode") {
                        isEditing.toggle()
                        if isEditing && addNew {
                            addNew.toggle()
                        }
                        if isEditing {imageName = "mouthDiagramNoLabels"
                            headerText = "Edit Mode"}
                    }
                    
                }
                
                HStack {
                    CustomButton(buttonLabel: "Add Mode") {
                        addNew.toggle()
                        if isEditing && addNew {
                            isEditing.toggle()
                        }
                        if addNew {imageName = "mouthDiagram"
                        headerText = "Add New Sore"} else {imageName = "mouthDiagramNoLabels"}

                    }

                    NavigationButton(destination: DailyLogView(), label: "Survey")
                }
                    
                    NavigationLink("", destination: SoreLocationView(imageName: selectedLocation, isEditing: isEditing), isActive: $locationIsSelected)
                    
            

                
                
                
                
            }
        }
        .onAppear {
            fetchSoreHistory()
            if addNew {
                imageName = "mouthDiagram"
            }
            lastLog = loadLastLog()
        }
        
    }

    
    private func fetchSoreHistory() {
        soresHistory = AppDataManager.loadJsonData(fileName: Constants.soreDataFileName, type: [CankerSore].self) ?? []
    }
    
    
    
}

func loadLastLog() -> DailyLog? {
    if let logFiles = AppDataManager.loadJsonData(fileName: Constants.dailyLogFileName, type: [DailyLog].self) {
        return logFiles.last
    }
    else {
        return nil
    }
    
    }

func checkIfDailyLogUpToDate(lastLog: DailyLog) -> Bool {
    
    if DailyLog.self == nil {
        return false
    } else {
        let currentDate = Date()
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.hour], from: lastLog.date, to: currentDate)
        if let hours = components.hour, hours <= 20 {
            return true
        } else {
            return false
        }
    }
    

}

func selectLocation(at location: CGPoint) -> String {
    let diagramWidth = Constants.diagramWidth
    let diagramHeight = Constants.diagramHeight
    var selectedLocation: String = "none"
    
    if location.x < diagramWidth * 0.33 {
        if location.y < diagramHeight * 0.5 {
            selectedLocation = "leftCheek"
        } else {
            selectedLocation = "mouthDiagram"
        }
    } else if location.x < diagramWidth * 0.66 {
        if location.y < diagramHeight * 0.5 {
            selectedLocation = "upperGums"
        } else {
            selectedLocation = "tongue"
        }
    
        
    } else {
        if location.y < diagramHeight * 0.5 {
            selectedLocation = "rightCheek"
        } else {
            selectedLocation = "lowerGums"
        }
    }
    
    return selectedLocation
}

#Preview {
    SoreHistoryView(isEditing: false, addNew: false, soresHistory: [])
}
