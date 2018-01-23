//
//  TestFileManager.swift
//  HereAndThere
//
//  Created by Reiaz Gafar on 1/22/18.
//  Copyright © 2018 HereAndThere. All rights reserved.
//

import Foundation


fileprivate struct SavedVenue: Codable {
    let venue: Venue
    let tip: String?
}

fileprivate struct UserCollection: Codable {
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
            favoritedImages = try PropertyListDecoder().decode([String : [SavedVenue]].self, from: data)
        } catch {
            print("Plist decoding error. \(error.localizedDescription)")
        }
    }
    
    // Returns this object's array
    func getCollections() -> [String : [SavedVenue]] {
        return userCollections
    }
    
    //Saving Images To Disk
    func saveImage(with imgUrl: String, image: UIImage) -> Bool {
        
        let imgPng = UIImagePNGRepresentation(image)!
        let imagePath = dataFilePath(withPathName: UUID().description)
        
        do {
            try imgPng.write(to: imagePath, options: .atomic)
        } catch {
            print("Error saving image. \(error.localizedDescription)")
            return false
        }
        return true
    }
    
    func getImage(with imgUrl: String) -> UIImage? {
        do {
            let imgPath = dataFilePath(withPathName: "\(imgUrl.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)")
            let data = try Data(contentsOf: imgPath)
            return UIImage(data: data)
        }
        catch {
            //print(error.localizedDescription)
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
    func addFavoritedImage(city: String, imgUrl: String, image: UIImage) -> Bool {
        
        if saveImage(with: imgUrl, image: image) {
            let favImage = FavoritedImage(city: city, imgUrl: imgUrl)
            favoritedImages.append(favImage)
            return true
        }
        return false
    }
    
    // Deletes
    func deleteCollections() {
        userCollections.removeAll()
    }
    
    
    
    
}
