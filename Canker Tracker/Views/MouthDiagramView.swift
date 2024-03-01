import Foundation
import SwiftUI


struct MouthDiagramView: View {
    let locations = ["roofOfMouth", "Tongue", "underTongue", "cheek", "cheek", "gums", "gums", "lips", "lips"]
    let diagramHeight: CGFloat = 350
    let diagramWidth: CGFloat = 350
    @State private var selectedLocation: String = "None"
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("\(selectedLocation == "None" ? "Tap on the diagram to select a location." : "Selected Location: \(selectedLocation)")")
            Spacer()
            Image("mouthDiagram")
                .resizable()
                .scaledToFit()
                .frame(width: diagramWidth, height: diagramHeight)
                .contentShape(Rectangle())
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onEnded { value in
                            let location = value.location
                            
                            selectLocation(at: location)
                        }
                )
            
            Spacer()
            
            if selectedLocation == "None" {
                GreyedOutButton()
            }
            else {
                NavigationButton(destination: VisualSelectorView(imageName: selectedLocation), label: "Next")
            }
            

        }
        
        
        
        
    }
    
    func selectLocation(at location: CGPoint) {
        
        print(location)
        
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
    }
}
#Preview {
    MouthDiagramView()
}

