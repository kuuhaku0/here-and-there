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

//	let date = "20180118" //YYYYMMDD
		let date = Date().description.prefix(10).replacingOccurrences(of: "-", with: "") //20180118 //YYYYMMDD

		let endpoint = "https://api.foursquare.com/v2/venues/\(venueID)/photos?&client_id=\(fourSquareClientId)&client_secret=\(fourSquareClientSecret)&v=\(date)"

		guard let url = URL(string: endpoint) else {return}

		let task =  URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
			if let error = error {completion(error, nil)}
			else if let data = data {
				do {
					let photosJSON = try JSONDecoder().decode(PhotoJSONResponse.self, from: data)
					let photos = photosJSON.response.photos.items
					print(photos)

//					for getting just image string
					//let size = “100x100”
					//let size = “300x300”
					//let imageStr = photo.prefix + size + photo.suffix


					completion(nil, photos)
				}
				catch {print("FourSquare Photo API call failed - Decoding Error: \(error)")}
			}
		})
		task.resume()
	}
}

