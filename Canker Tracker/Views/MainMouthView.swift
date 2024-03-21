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


    
    var body: some View {
        NavigationStack {
            VStack {
                Text("All Sores")
                    .font(.title)
                
                Spacer()
                
                ExistingSoresDiagram(soresList: soresList,diagramName: "mouthDiagramNoLabels" , selectedSore: $selectedSore)

            }
            
            Spacer()
            
            VStack {

                Form {
                    Section {
                        
                        Text("Start Date: \(formatDate(date: selectedSore?.lastUpdated.first))")
                        Text("Number of Days: \(selectedSore?.numberOfDays ?? 1)")
                        Text("Pain Level: \(Int(selectedSore?.painLevel.first ?? 0))")
                        Text("Size: \(Int(selectedSore?.soreSize.first ?? 0)) mm")
                        NavigationButton(destination: EditSoreView(imageName: selectedSore?.locationImage ?? "", soreLogUptoDate: true), label: "Edit")
                    }
                }
            }
            
            Spacer()
            
            HStack {
                
                NavigationButton(destination: SelectMouthZoneView( soreLogUptoDate: soreLogUptoDate), label: "Add New")
                
                CustomButton(buttonLabel: "Clear") {
                    
                    resetAppData()
                    
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
            }
            .onEnded { value in
                let location = value.location
                if let nearestSore = TapManager.findNearestScaledSore(to: location, from: soresList) {
                    selectedSore = nearestSore
                }
            }
    }
    
    
    
}

#Preview {
    MainMouthView()
}

