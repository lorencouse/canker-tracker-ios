import Foundation
import SwiftUI


struct MouthDiagramView: View {
    @State var isEditing: Bool = false
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
                                selectedLocation = selectLocation(at: location)
                                locationIsSelected = true
                            }
                    )
                
                Spacer()
                
                HStack {
                    CustomButton(buttonLabel: "Add") {
                        isEditing = false
                    }
                    
                    CustomButton(buttonLabel: "Edit") {
                        isEditing = true
                    }

                }

                
                
                
                NavigationLink("", destination: SoreLocationView(imageName: selectedLocation, isEditing: isEditing), isActive: $locationIsSelected)
                
            }
            
        }
    }
    
    

}


func selectLocation(at location: CGPoint) -> String {
    let diagramWidth = Constants.diagramWidth
    let diagramHeight = Constants.diagramHeight
    var selectedLocation: String = "none"
    
    if location.x < diagramWidth * 0.33 {
        if location.y < diagramHeight * 0.5 {
            selectedLocation = "leftCheek"
        } else {
            selectedLocation = "mouthDiagram"
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
    
    return selectedLocation
}

#Preview {
    MouthDiagramView()
}

