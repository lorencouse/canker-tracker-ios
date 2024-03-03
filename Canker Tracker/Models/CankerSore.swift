//
//  CankerSore.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/3/2.
//

import Foundation

struct CankerSore: Decodable, Encodable {
//    let id: UUID
    let startDate: Date
    let heeled: Bool
    let numberOfDays: Int
    let location: String
    let size: [CGFloat]
    let painLevel: [CGFloat]
    let coordinates: CGPoint
}
