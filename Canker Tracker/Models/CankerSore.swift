//
//  CankerSore.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/3/2.
//

import Foundation
import CoreGraphics

struct CankerSore: Codable, Hashable {
    let lastUpdated: [Date]
    let numberOfDays: Int
    let healed: Bool
    let location: String
    let size: [Double]
    let painLevel: [Double]
    let xCoordinate: Double
    let yCoordinate: Double
}
