//
//  AppDataManager.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/3/2.
//

import Foundation

class AppDataManager {
    static let shared = AppDataManager()
    
//    func appendCankerSore(_ cankerSore: CankerSore) {
//        var soresHistory = AppDataManager.loadJsonData(fileName: Constants.soreDataFileName, type: [CankerSore].self) ?? []
//        soresHistory.append(cankerSore)
//        saveJsonData([soresHistory], fileName: Constants.soreDataFileName)
//
//    }
    
    
    
    func saveJsonData<T: Codable>(_ objectArray: [T], fileName: String) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // Optional: Makes the JSON easier to read.
        
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let filePath = documentDirectory.appendingPathComponent(fileName)
            
            do {
                let encoded = try encoder.encode(objectArray)
                try encoded.write(to: filePath, options: .atomic)
                print("Data saved to \(filePath)")
            } catch {
                print("Failed to save data: \(error.localizedDescription)")
            }
        }
    }
    
    static func loadJsonData<T: Decodable>(fileName: String, type: T.Type) -> T? {
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
    
    func appendJsonData<T: Codable>(_ newObjects: [T], fileName: String) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // Makes the JSON easier to read.
        
        let fileManager = FileManager.default
        if let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let filePath = documentDirectory.appendingPathComponent(fileName)
            
            // Attempt to load existing data
            var objectsToSave: [T] = []
            if let data = try? Data(contentsOf: filePath), let existingObjects = try? JSONDecoder().decode([T].self, from: data) {
                objectsToSave.append(contentsOf: existingObjects)
            }
            
            // Append new objects to the loaded data
            objectsToSave.append(contentsOf: newObjects)
            
            // Save the updated array back to the file
            do {
                let encoded = try encoder.encode(objectsToSave)
                try encoded.write(to: filePath, options: .atomic)
                print("Data appended to \(filePath)")
            } catch {
                print("Failed to append data: \(error.localizedDescription)")
            }
        }
    }
    
    func updateLastEntry<T: Codable>(_ newObject: T, fileName: String) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let fileManager = FileManager.default
        if let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let filePath = documentDirectory.appendingPathComponent(fileName)
            
            var objectsToUpdate: [T] = []
            if let data = try? Data(contentsOf: filePath), let existingObjects = try? JSONDecoder().decode([T].self, from: data) {
                objectsToUpdate = existingObjects
            }
            
            if !objectsToUpdate.isEmpty {
                objectsToUpdate[objectsToUpdate.count - 1] = newObject
            } else {
                objectsToUpdate.append(newObject)
            }
            
            // Save the updated array back to the file
            do {
                let encoded = try encoder.encode(objectsToUpdate)
                try encoded.write(to: filePath, options: .atomic)
                print("Last entry updated in \(filePath)")
            } catch {
                print("Failed to update last entry: \(error.localizedDescription)")
            }
        }
    }

    
    
    static func deleteJsonData(fileName: String) {
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

