//
//  AppDataManager.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/3/2.
//

import Foundation

class AppDataManager {
    static let shared = AppDataManager()
    
    func saveCankerSoreData(_ CankerSore: CankerSore) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(CankerSore) {
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let filePath = documentDirectory.appendingPathComponent("cankerSoreData.json")
                try? encoded.write(to: filePath)
            }
        }
    }
    
    static func loadFile<T: Decodable>(fileName: String, type: T.Type) -> T? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Documents directory not found.")
            return nil
        }
        
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            print("Error reading data from file: \(error)")
            return nil
        }
    }
    
    static func deleteFile(fileName: String) {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        guard let fileURL = documentsDirectory?.appendingPathComponent(fileName) else {
            print("Failed to get the file URL")
            return
        }
        
        do {
            try fileManager.removeItem(at: fileURL)
            print("\(fileName) successfully deleted")
        } catch {
            print("Error deleting file: \(error)")
        }
    }
    
    
    
}
