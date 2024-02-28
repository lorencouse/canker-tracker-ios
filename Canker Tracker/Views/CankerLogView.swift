import Foundation
import SwiftUI

struct CankerLogView: View {
    var body: some View {
        MouthDiagramView()
    }
}

struct MouthDiagramView: View {
    let locations = ["Roof", "Tongue Top", "Under Tongue", "Left Cheek", "Right Cheek", "Upper Gums", "Lower Gums", "Upper Lip", "Lower Lip"]
    let diagramHeight: CGFloat = 350
    let diagramWidth: CGFloat = 350
    @State private var selectedLocation: String = "None"
    
    var body: some View {
        VStack {
            Text("Tap on the diagram to select a location.")
            Text("Selected Location: \(selectedLocation)")
            
            Image("mouthDiagram") // Your actual image asset name
                .resizable()
                .scaledToFit()
                .frame(width: diagramWidth, height: diagramHeight) // Set this to the size you want
                .contentShape(Rectangle()) // This makes the entire area tappable, not just the image's non-transparent parts
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onEnded { value in
                            // Get the location of the tap
                            let location = value.location
                            // Use location to determine which part of the image was tapped
                            selectLocation(at: location)
                        }
                )
        }
    }
    
    func selectLocation(at location: CGPoint) {

        print(location)
        
        // Placeholder logic to select a location
        if location.x < diagramWidth * 0.33 {
            if location.y < diagramHeight * 0.33 {
                selectedLocation = "Upper Gums"
            } else if location.y < diagramHeight * 0.66 {
                selectedLocation = "Left Cheek"
            } else {
                selectedLocation = "Lower Gums"
            }
        } else if location.x < diagramWidth * 0.66 {
            if location.y < diagramHeight * 0.25 {
                selectedLocation = "Upper Lip"
            } else if location.y < diagramHeight * 0.5 {
                selectedLocation = "Roof"
            }else if location.y < diagramHeight * 0.75 {
                selectedLocation = "Tongue Top"
            } else {
                selectedLocation = "Lower Lip"
            }
        } else {
            if location.y < diagramHeight * 0.33 {
                selectedLocation = "Right Cheek"
            } else if location.y < diagramHeight * 0.66 {
                selectedLocation = "Right Cheek"
            } else {
                selectedLocation = "Under Tongue"
            }
        }
    }
}
#Preview {
    CankerLogView()
}

