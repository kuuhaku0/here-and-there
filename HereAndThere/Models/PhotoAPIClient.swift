//  PhotoAPIClient.swift
//  HereAndThere
//  Created by Winston Maragh on 1/17/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.

import Foundation

// MARK: - FourSquare Photo API Client
struct PhotoAPIClient {
	private init(){}
	static let manager = PhotoAPIClient()
	func getVenuePhotos(venueID: String, completion: @escaping (Error?, [PhotosItem]?) -> Void) {

		//ONLY FOR TESTING:
//				let venueID = "43695300f964a5208c291fe3"
//				let date = "20180118"
//				let token = "DNQEHPMM30W0XUS0Z5XO24HWSJ2TOR1VLD0QIJQ20KBRS3SU"
//				let endpoint = "https://api.foursquare.com/v2/venues/\(venueID)/photos?&oauth_token=\(token)&v=\(date)"
		let endpoint = "https://api.foursquare.com/v2/venues/43695300f964a5208c291fe3/photos?&oauth_token=DNQEHPMM30W0XUS0Z5XO24HWSJ2TOR1VLD0QIJQ20KBRS3SU&v=20180118"
		

		guard let url = URL(string: endpoint) else {return}

		let task =  URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
			if let error = error {completion(error, nil)}
			else if let data = data {
				do {
					let photosJSON = try JSONDecoder().decode(PhotoJSONResponse.self, from: data)
					let photos = photosJSON.response.photos.items
					completion(nil, photos)
				}
				catch {print("FourSquare Photo API call failed - Decoding Error: \(error)")}
			}
		})
		task.resume()
	}
}
