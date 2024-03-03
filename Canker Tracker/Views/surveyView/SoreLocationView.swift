//
//  TongueView.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/2/28.
//

import Foundation
import SwiftUI

struct SoreLocationView: View {
    let imageName: String
    @State var addMoreSores: Bool = false
    @State var finishedAdding: Bool = false
    @State private var selectedLocationX: Double? = nil
    @State private var selectedLocationY: Double? = nil
    @State private var diagramWidth: Double = Constants.diagramWidth
    @State private var diagramHeight: Double = Constants.diagramHeight
    @State private var soreSize: Double = 3
    @State private var painScore: Double = 3

    var body: some View {
        
        VStack {
            Spacer()

            Text("Tap Sore Location")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(.center)

            Spacer()

            GeometryReader { geometry in
                ZStack(alignment: .topLeading) {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: diagramWidth, height: diagramHeight)
                        .contentShape(Rectangle())
                        .edgesIgnoringSafeArea(.all)

                    Color.clear
                        .contentShape(Rectangle())
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onEnded { value in
                                    self.selectedLocationX = Double(value.location.x)
                                    self.selectedLocationY = Double(value.location.y)
                                }
                        )
                    
                    if let x = selectedLocationX, let y = selectedLocationY {
                        Circle()
                            .fill(Constants.painScaleColors[Int(painScore)])
                            .stroke(Color.black, lineWidth: 1)
                            .frame(width: soreSize * 2, height: soreSize * 2)
                            .offset(x: x - soreSize, y: y - soreSize)
                    }
                }
            }
            .frame(width: diagramWidth, height: diagramHeight)

            Text("Sore Size: \(Int(soreSize)) mm")
            Slider(value: $soreSize, in: 1...20, step: 1)
                .padding()
                .disabled(selectedLocationX == nil || selectedLocationY == nil)

            Text("Pain Score: \(Int(painScore))")
            Slider(value: $painScore, in: 0...10, step: 1)
                .padding()
                .disabled(selectedLocationX == nil || selectedLocationY == nil)

            HStack {
                CustomButton(buttonLabel: "Finish") {
                    saveCankerSore()
                    finishedAdding = true
                }
                .disabled(selectedLocationX == nil || selectedLocationY == nil)

                CustomButton(buttonLabel: "Add More") {
                    saveCankerSore()
                    addMoreSores = true
                }
                .disabled(selectedLocationX == nil || selectedLocationY == nil)
            }

            NavigationLink(destination: MouthDiagramView(), isActive: $addMoreSores) { EmptyView() }
            NavigationLink(destination: SoreHistoryView(), isActive: $finishedAdding) { EmptyView() }
        }
    }

    private func saveCankerSore() {
        if let x = selectedLocationX, let y = selectedLocationY {
            let newCankerSore = CankerSore(
                lastUpdated: [Date()],
                numberOfDays: 1,
                healed: false,
                location: imageName,
                size: [soreSize],
                painLevel: [painScore],
                xCoordinate: x,
                yCoordinate: y
            )
            AppDataManager.shared.saveCankerSoreData(newCankerSore)
        }
    }
}
#Preview {
    SoreLocationView( imageName: "leftCheek")
}


