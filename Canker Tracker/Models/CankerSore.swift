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
    var healed: Bool
    let location: String
    var soreSize: [Double]
    var painLevel: [Double]
    let xCoordinateZoomed: Double
    let yCoordinateZoomed: Double
    let xCoordinate: Double
    let yCoordinate: Double
}

struct ImageScale {
    var scaleX: Double
    var scaleY: Double
    var xOffset: Double
    var yOffset: Double
    var viewName: String
}
