//
//  NewMouthMainView.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/3/16.
//

import Foundation
import SwiftUI

struct MainMouthView: View {
    @State private var soresList: [CankerSore] = []
    @State private var lastLog: DailyLog? = nil
    @State private var selectedSore: CankerSore?
    @State private var soreLogUptoDate: Bool = false
    @State private var selectedZone: String = "none"
    @State private var circleOutlineColor: Color = .red
    let diagramSize: Double = Constants.diagramHeight

    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("All Sores")
                    .font(.title)
                
                Spacer()
                
                ZStack(alignment: .topLeading) {
                    Image("mouthDiagramNoLabels")
                        .resizable()
                        .scaledToFit()
                        .frame(width: diagramSize, height: diagramSize)
                        .contentShape(Rectangle())
                        .edgesIgnoringSafeArea(.all)
                        .gesture(
                                nearestSoreGesture

                            )
                    
                    ForEach(soresList, id:\.self) {
                        sore in
                        DrawScaledSoreCircle(selectedSore: sore)
                        
                    }
                    
                }
                .frame(width: diagramSize, height: diagramSize)
                
                Text("Selected Sore X: \(selectedSore?.xCoordinateScaled.map { String($0) } ?? "") Y: \(selectedSore?.yCoordinateScaled.map { String($0) } ?? "")")
                
                HStack {
                    
                    

                    
                    NavigationButton(destination: SelectMouthZoneView( soreLogUptoDate: soreLogUptoDate), label: "Add New")
                    
                    CustomButton(buttonLabel: "Clear") {
                        
                        resetAppData()
                        
                    }
                }
            }
        }
        .onAppear {
            lastLog = DailyLogManager.loadLastLog()
            soreLogUptoDate = DailyLogManager.checkIfDailyLogUpToDate(lastLog: lastLog)
            soresList = CankerSoreManager.loadActiveSores(imageName: nil)
        }
    }
    
    
    private func resetAppData() {
        
        AppDataManager.deleteJsonData(fileName: Constants.dailyLogFileName)
        AppDataManager.deleteJsonData(fileName: Constants.soreDataFileName)
        soresList = []
        soreLogUptoDate = false

    }
    
}

extension MainMouthView {
    var nearestSoreGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                // Optionally, you can handle start location here to ensure it's a tap.
            }
            .onEnded { value in
                let location = value.location
                if let nearestSore = TapManager.findNearestSore(to: location, from: soresList) {
                    selectedSore = nearestSore
                    // Assuming your drawing logic will respond to this change.
                }
            }
    }
}

#Preview {
    MainMouthView()
}

