//
//  TestFileManager.swift
//  HereAndThere
//
//  Created by Reiaz Gafar on 1/22/18.
//  Copyright © 2018 HereAndThere. All rights reserved.
//

import Foundation
import UIKit

struct SavedVenue: Codable {
    let venue: Venue
    let venueID: String
    let tip: String?
}

struct UserCollection: Codable {
    let collections: [String : [SavedVenue]]
}

class DataPersistenceHelper {
    
    // Singleton
    private init() {}
    static let manager = DataPersistenceHelper()
    
    let filePath = "FavoritedCollections.plist"
    
    // Save everytime it changes
    private var userCollections = [String : [SavedVenue]]() {
        didSet {
            saveCollections()
        }
    }
    
    // Gets the doc dir path
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // Gets the file path in doc dir
    private func dataFilePath(withPathName path: String) -> URL {
        return DataPersistenceHelper.manager.documentsDirectory().appendingPathComponent(path)
    }
    
    // Loads
    func loadCollections() {
        var data = Data()
        do {
            data = try Data.init(contentsOf: DataPersistenceHelper.manager.dataFilePath(withPathName: filePath))
        } catch {
            print("Error retrieving data. \(error.localizedDescription)")
            return
        }
        
        do {
            userCollections = try PropertyListDecoder().decode([String : [SavedVenue]].self, from: data)
        } catch {
            print("Plist decoding error. \(error.localizedDescription)")
        }
    }
    
    // Returns this object's array
    func getCollections() -> [String : [SavedVenue]] {
        return userCollections
    }
    
    //Saving Images To Disk
    func saveImage(with venueID: String, image: UIImage) -> Bool {
        
        let imgPng = UIImagePNGRepresentation(image)!
        let imagePath = dataFilePath(withPathName: "\(venueID.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)")
        
        do {
            try imgPng.write(to: imagePath, options: .atomic)
        } catch {
            print("Error saving image. \(error.localizedDescription)")
            return false
        }
        return true
    }
    
    func getImage(with venueID: String) -> UIImage? {
        do {
            let imgPath = dataFilePath(withPathName: "\(venueID.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)")
            let data = try Data(contentsOf: imgPath)
            return UIImage(data: data)
        }
        catch {
            return nil
        }
    }
    
    
    
    
    // Saves current array into the doc dir
    private func saveCollections() {
        var data = Data()
        
        do {
            data = try PropertyListEncoder().encode(userCollections)
        } catch {
            print("Plist encoding error. \(error.localizedDescription)")
            return
        }
        
        do {
            try data.write(to: DataPersistenceHelper.manager.dataFilePath(withPathName: filePath), options: .atomic)
            
        } catch {
            print("Writing to disk error. \(error.localizedDescription)")
        }
        
    }
    
    // Also saves the image in the doc dir
    func addVenueToCollection(collectionName: String, venue: Venue, tip: String?, venueID: String, image: UIImage) -> Bool {
        
        let venueToSave = [SavedVenue(venue: venue, venueID: venueID, tip: tip)]
        
        if saveImage(with: venueID, image: image) {
            userCollections[collectionName] = venueToSave
            return true
        }
        return false
    }
    
    // Deletes
    func deleteCollections() {
        userCollections.removeAll()
    }
    
    
    
    
}
