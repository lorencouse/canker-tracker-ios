//
//  SoreHistoryView.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/3/3.
//

import Foundation
import SwiftUI

struct SoreHistoryView: View {
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
                Image("mouthDiagramNoLabels")
                    .resizable()
                    .scaledToFit()
                    .frame(width: diagramWidth, height: diagramHeight)
                    .contentShape(Rectangle())
                    .edgesIgnoringSafeArea(.all)
                
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
                
                NavigationButton(destination: MouthDiagramView(), label: "Add New")
                
             }
            
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
    SoreHistoryView(soresHistory: [])
}
