//  PhotoAPIClient.swift
//  HereAndThere
//  Created by Winston Maragh on 1/17/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.

import Foundation

// MARK: - FourSquare Photo API Client
//struct PhotoAPIClient {
//    private init(){}
//    static let manager = PhotoAPIClient()
//    func getVenuePhotos(venueID: String, completion: @escaping (Error?, [PhotosItem]?) -> Void) {
//
//            let date = "20180118"
//            let endpoint = "https://api.foursquare.com/v2/venues/\(venueID)/photos?&client_id=\(fourSquareClientId)&client_secret=\(fourSquareClientSecret)&v=\(date)"
//
//        guard let url = URL(string: endpoint) else {return}
//
//        let task =  URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
//            if let error = error {completion(error, nil)}
//            else if let data = data {
//                do {
//                    let photosJSON = try JSONDecoder().decode(PhotoJSONResponse.self, from: data)
//                    let photos = photosJSON.response.photos.items
//                    print(photos)
//                    completion(nil, photos)
//                }
//                catch {print("FourSquare Photo API call failed - Decoding Error: \(error)")}
//            }
//        })
//        task.resume()
//    }
//}

