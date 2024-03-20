//
//  SoreObjectView.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/3/3.
//

import Foundation
import SwiftUI



//func drawExistingSore(sore: CankerSore, circleOutlineColor: Color) -> some View {
//
//            Circle()
//                .fill(Constants.painScaleColors[Int(sore.painLevel.last)]) // Use last to get the most recent pain level
//                .stroke(circleOutlineColor, lineWidth: 1)
//                .frame(width: (sore.soreSize.last) * 2, height: (sore.soreSize.last) * 2) // Use last to get the most recent size
//                .offset(x: sore.xCoordinateScaled - (sore.soreSize.last), y: sore.yCoordinateScaled - (sore.soreSize.last))
//
//}



struct DrawZoomedSoreCircle: View {
    var selectedSore: CankerSore
    var body: some View {
        Circle()
            .fill(Constants.painScaleColors[Int(selectedSore.painLevel.last ?? 0)])
            .stroke(Color.black, lineWidth: 1)
            .frame(width: (selectedSore.soreSize.last ?? 0) * 2, height: (selectedSore.soreSize.last ?? 0) * 2)
            .offset(x: (selectedSore.xCoordinateZoomed ?? 0) - (selectedSore.soreSize.last ?? 0), y: (selectedSore.yCoordinateZoomed ?? 0) - (selectedSore.soreSize.last ?? 0))
    }
}

struct DrawScaledSoreCircle: View {
    var selectedSore: CankerSore
    var body: some View {
        Circle()
            .fill(Constants.painScaleColors[Int(selectedSore.painLevel.last ?? 0)])
            .stroke(Color.black, lineWidth: 1)
            .frame(width: (selectedSore.soreSize.last ?? 0) * 2, height: (selectedSore.soreSize.last ?? 0) * 2)
            .offset(x: (selectedSore.xCoordinateScaled ?? 0) - (selectedSore.soreSize.last ?? 0), y: (selectedSore.yCoordinateScaled ?? 0) - (selectedSore.soreSize.last ?? 0))
    }
}




    

//struct SoreCircleMainView: View {
//    
//    var painLevel: Double
//    var circleOutlineColor: Color
//    var soreSize: Double
//    let x: Double
//    let y: Double
//    
//    var body: some View {
//        Circle()
//            .fill(Constants.painScaleColors[Int(painLevel)])
//            .stroke(circleOutlineColor, lineWidth: 1)
//            .frame(width: soreSize * 2, height: soreSize * 2)
//            .offset(x: x - soreSize, y: y - soreSize)
//    }
//    
//}
//
//struct SoreCircleObjectZoomedView: View {
//    
//    var sore: CankerSore
//    var body: some View {
//        Circle()
//            .fill(Constants.painScaleColors[Int(sore.painLevel[0])])
//            .stroke(Color.black, lineWidth: 1)
//            .frame(width: sore.soreSize[0] * 2, height: sore.soreSize[0] * 2)
//            .offset(x: sore.xCoordinateZoomed ?? 0 - sore.soreSize[0], y: sore.yCoordinateZoomed ?? 0 - sore.soreSize[0])
//    }
//}

