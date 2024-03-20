//
//  CankerSore.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/3/2.
//

import Foundation
import CoreGraphics

struct CankerSore: Codable, Hashable {
    let id: UUID
    var lastUpdated: [Date]
    var numberOfDays: Int
    let locationImage: String
    var soreSize: [Double]
    var painLevel: [Double]
    var xCoordinateZoomed: Double?
    var yCoordinateZoomed: Double?
    var xCoordinateScaled: Double?
    var yCoordinateScaled: Double?
}

struct ImageScale {
    var scaleX: Double
    var scaleY: Double
    var xOffset: Double
    var yOffset: Double
    var viewName: String
}
