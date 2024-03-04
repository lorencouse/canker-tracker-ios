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
    @State var selectedLocation: String = "none"
    @State var locationIsSelected: Bool = false
    @State var imageName: String = "mouthDiagramNoLabels"
    @State var soresHistory: [CankerSore] = []
    let diagramHeight: Double = Constants.diagramHeight
    let diagramWidth: Double = Constants.diagramWidth
    
    var body: some View {
        VStack {
            
            Spacer()
            Text("Canker Sore History")
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
                                selectedLocation = selectLocation(at: location)
                                locationIsSelected = true
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
                    AppDataManager.deleteFile(fileName: Constants.soreDataFileName)
                    fetchSoreHistory()
                }
                CustomButton(buttonLabel: "Edit") {
                    isEditing = true
                    imageName = "mouthDiagram"
                }
                

                

                
             }
            
            HStack {
                NavigationButton(destination: MouthDiagramView(), label: "Add New")
                NavigationButton(destination: DailyLogView(), label: "Survey")
            }
            
            NavigationLink("", destination: SoreLocationView(imageName: selectedLocation, isEditing: isEditing), isActive: $locationIsSelected)
            
        }
        .onAppear {
            fetchSoreHistory()
        }
        
    }

    
    private func fetchSoreHistory() {
        soresHistory = AppDataManager.loadFile(fileName: Constants.soreDataFileName, type: [CankerSore].self) ?? []
        print(soresHistory)
    }
    
}

#Preview {
    SoreHistoryView(isEditing: false, soresHistory: [])
}
