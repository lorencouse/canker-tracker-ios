//
//  SoreObjectView.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/3/3.
//

import Foundation
import SwiftUI

struct SoreObjectView: View {

    
    var sore: CankerSore
    var body: some View {
        Circle()
            .fill(Constants.painScaleColors[Int(sore.painLevel[0])])
            .stroke(Color.black, lineWidth: 1)
            .frame(width: sore.size[0] * 2, height: sore.size[0] * 2)
            .offset(x: sore.xCoordinate - sore.size[0], y: sore.yCoordinate - sore.size[0])
    }
}
