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
    @State var headerText: String = "Canker Sore History"
    let diagramHeight: Double = Constants.diagramHeight
    let diagramWidth: Double = Constants.diagramWidth
    
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
                        .frame(width: diagramWidth, height: diagramHeight)
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
                .frame(width: diagramWidth, height: diagramHeight)
                
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
        }
        
    }

    
    private func fetchSoreHistory() {
        soresHistory = AppDataManager.loadJsonData(fileName: Constants.soreDataFileName, type: [CankerSore].self) ?? []
    }
    
    
    
}

#Preview {
    SoreHistoryView(isEditing: false, addNew: false, soresHistory: [])
}
