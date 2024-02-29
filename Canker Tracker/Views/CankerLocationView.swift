import Foundation
import SwiftUI

struct CankerLocationView: View {
    var body: some View {
        MouthDiagramView()
    }
}

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
            
            NavigationButton(destination: VisualSelectorView(imageName: selectedLocation), label: "Next")
        }
        
        
        
        
    }
    
    func selectLocation(at location: CGPoint) {
        
        print(location)
        
        if location.x < diagramWidth * 0.33 {
            if location.y < diagramHeight * 0.33 {
                selectedLocation = "gums"
            } else if location.y < diagramHeight * 0.66 {
                selectedLocation = "cheek"
            } else {
                selectedLocation = "gums"
            }
        } else if location.x < diagramWidth * 0.66 {
            if location.y < diagramHeight * 0.25 {
                selectedLocation = "lips"
            } else if location.y < diagramHeight * 0.5 {
                selectedLocation = "topOfMouth"
            }else if location.y < diagramHeight * 0.75 {
                selectedLocation = "tongue"
            } else {
                selectedLocation = "lips"
            }
        } else {
            if location.y < diagramHeight * 0.33 {
                selectedLocation = "cheek"
            } else if location.y < diagramHeight * 0.66 {
                selectedLocation = "cheek"
            } else {
                selectedLocation = "underTongue"
            }
        }
    }
}
#Preview {
    CankerLocationView()
}

