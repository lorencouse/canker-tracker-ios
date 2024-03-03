//
//  Constants.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/3/3.
//

import Foundation
import SwiftUI

struct Constants {
    static let soreDataFileName = "cankerSoreData.json"
    static let painScaleColors: [Color] = [
        Color.pain0,
        Color.pain1,
        Color.pain2,
        Color.pain3,
        Color.pain4,
        Color.pain5,
        Color.pain6,
        Color.pain7,
        Color.pain8,
        Color.pain9,
        Color.pain10
    ]
    static let imageScaleValues: [String: ImageScale] = [
        "tongue": ImageScale(scaleX: 0.6, scaleY: 0.6, xOffset: 74.2, yOffset: 162.73),
        "lowerGums": ImageScale(scaleX: 0.558, scaleY: 0.558, xOffset: 81.30, yOffset: 175.87),
        "upperGums": ImageScale(scaleX: 0.576, scaleY: 0.576, xOffset: 81.16, yOffset: -49.2),
        "leftCheek": ImageScale(scaleX: 0.338, scaleY: 1.583, xOffset: 0, yOffset: -191.16),
        "rightCheek": ImageScale(scaleX: 0.338, scaleY: 1.583, xOffset: 250, yOffset: -191.16)
    ]
    static let diagramWidth: Double = 380
    static let diagramHeight: Double = 380
}
