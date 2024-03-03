import Foundation
import SwiftUI


struct MouthDiagramView: View {
    let diagramHeight: CGFloat = Constants.diagramHeight
    let diagramWidth: CGFloat = Constants.diagramWidth
    @State private var selectedLocation: String = "none"
    @State private var locationIsSelected: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Text("Select Canker Sore Location")
                    .font(.title)

                Spacer()
                Image("mouthDiagram") 
                    .resizable()
                    .scaledToFit()
                    .frame(width: diagramWidth, height: diagramHeight)
                    .contentShape(Rectangle())
                    .edgesIgnoringSafeArea(.all)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onEnded { value in
                                let location = value.location
                                selectLocation(at: location)
                            }
                    )
                
                Spacer()
                    NavigationLink("", destination: SoreLocationView(imageName: selectedLocation), isActive: $locationIsSelected)
                
            }
            
        }
    }
    
    func selectLocation(at location: CGPoint) {
        
        if location.x < diagramWidth * 0.33 {
            if location.y < diagramHeight * 0.5 {
                selectedLocation = "leftCheek"
            } else {
                selectedLocation = "lips"
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
        
        if selectedLocation != "none" {
            locationIsSelected = true
        }
    }

}
#Preview {
    MouthDiagramView()
}

