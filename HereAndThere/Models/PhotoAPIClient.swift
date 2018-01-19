//  PhotoAPIClient.swift
//  HereAndThere
//  Created by Winston Maragh on 1/17/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.

import Foundation
import Alamofire

// MARK: - FourSquare Photo API Client
struct PhotoAPIClient {

    private init(){}
    static let manager = PhotoAPIClient()
    
    private let CLIENT_ID = "PWWSABHMRSWVYZNHL1QG20A5050WJAI2MIU3AUFWVRQHCITA"
    private let CLIENT_SECRET = "WFF2451MT2QIYKDCQEXN3ADT5ZKCYQOFIRXPODYUZSSYBSDT"
    
    func getVenuePhotos(venueID: String, completion: @escaping ([PhotosItem]) -> Void) {
        let date = "20180118"
        let FOURSQUARE_PHOTO_URL = "https://api.foursquare.com/v2/venues/\(venueID)/photos?&client_id=\(CLIENT_ID)&client_secret=\(CLIENT_SECRET)&v=\(date)"
        
        Alamofire.request(FOURSQUARE_PHOTO_URL).responseJSON {(response) in
            if response.result.isSuccess {
                if let data = response.data {
                    do {
                        let JSON = try JSONDecoder().decode(PhotoJSONResponse.self, from: data)
                        let response = JSON.response
                        let allItems = response.photos
                        let photoItems = allItems.items
                        completion(photoItems)
                    }
                    catch {
                        print("Error processing data \(error)")
                    }
                }
            } else {
                print("Error\(String(describing: response.result.error))")
            }
        }
    }
}

