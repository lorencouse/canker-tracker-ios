//
//  SoreHistoryView.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/3/3.
//

import Foundation
import SwiftUI

struct SelectMouthZoneView: View {

    @State private var selectedX: Double? = nil
    @State private var selectedY: Double? = nil
    @State private var circleOutlineColor: Color = Color.black
    @State var selectedZone: String = "none"
    let diagramHeight: Double = Constants.diagramHeight
    @State var soreLogUptoDate: Bool
    @State private var locationIsSelected: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()
                Text("Select A Zone")
                    .font(.title)
                
                Spacer()
                
                ZStack(alignment: .topLeading) {
                    Image("mouthDiagram")
                        .resizable()
                        .scaledToFit()
                        .frame(width: diagramHeight, height: diagramHeight)
                        .contentShape(Rectangle())
                        .edgesIgnoringSafeArea(.all)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onEnded { value in
                                    let location = value.location

                                        selectedZone = TapManager.selectMouthZone(at: location)
                                        locationIsSelected = true

                                    
                                }
                        )
                                        
                }
                .frame(width: diagramHeight, height: diagramHeight)
                
                Spacer()
                    
                NavigationLink("", destination: AddSoreView(imageName: selectedZone, soreLogUptoDate: soreLogUptoDate), isActive: $locationIsSelected)
                
                
            }
        }
        .onAppear {


        }
        
    }
    

    
}





#Preview {
    SelectMouthZoneView( soreLogUptoDate: true)
}
