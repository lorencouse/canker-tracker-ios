//
//  TapManager.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/3/15.
//

import Foundation


struct TapManager {
    
    static func selectMouthZone(at location: CGPoint) -> String {
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
    
    static func distance(from point1: CGPoint, to point2: CGPoint) -> CGFloat {
        return sqrt(pow(point2.x - point1.x, 2) + pow(point2.y - point1.y, 2))
    }
    
    static func findNearestZoomedSore(to location: CGPoint, from existingSores: [CankerSore]) -> CankerSore? {
        
        let nearestSore = existingSores.min(by: { sore1, sore2 in
            let distance1 = distance(from: CGPoint(x: sore1.xCoordinateZoomed ?? 0, y: sore1.yCoordinateZoomed ?? 0), to: location)
            let distance2 = distance(from: CGPoint(x: sore2.xCoordinateZoomed ?? 0, y: sore2.yCoordinateZoomed ?? 0), to: location)
            return distance1 < distance2
        })
        
        return nearestSore
        
    }
    
    static func findNearestScaledSore(to location: CGPoint, from existingSores: [CankerSore]) -> CankerSore? {
        
        let nearestSore = existingSores.min(by: { sore1, sore2 in
            let distance1 = distance(from: CGPoint(x: sore1.xCoordinateScaled ?? 0, y: sore1.yCoordinateScaled ?? 0), to: location)
            let distance2 = distance(from: CGPoint(x: sore2.xCoordinateScaled ?? 0, y: sore2.yCoordinateScaled ?? 0), to: location)
            return distance1 < distance2
        })
        
        return nearestSore
        
    }
    
    
    
    
}
