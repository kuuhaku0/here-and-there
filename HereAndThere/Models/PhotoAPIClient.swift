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

	func getVenuePhotos(venueID: String, completion: @escaping ([PhotoObject]) -> Void) {
		let FOURSQUARE_PHOTO_URL = "https://api.foursquare.com/v2/venues/\(venueID)/photos?\(FourSquareAPIKeys.fourSquareAuthorization)"

		Alamofire.request(FOURSQUARE_PHOTO_URL).responseJSON {(response) in
			if response.result.isSuccess {
					if let data = response.data {
						do {
								let JSON = try JSONDecoder().decode(FourSquarePhotoObjectsJSON.self, from: data)
								let numOfPhotoObjects = JSON.response.photos.count //Int
								let photoObjects = JSON.response.photos.items //Object
								completion(photoObjects)
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

