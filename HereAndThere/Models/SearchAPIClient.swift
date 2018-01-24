//  SearchAPIClient.swift
//  HereAndThere
//  Created by Winston Maragh on 1/17/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.

import Foundation
import Alamofire

// MARK: - FourSquare Search API Client
struct SearchAPIClient {
	private init(){}
	static let manager = SearchAPIClient()

	func getVenues(from search: String, coordinate: String?, near: String?, completion: @escaping ([Venue]) -> Void) {

		var url = ""

		// using near
		if let near = near, near != "" {
			url = "https://api.foursquare.com/v2/venues/search?near=\(near)&query=\(search)\(FourSquareAPIKeys.fourSquareAuthorization)"
			print("near URL:")
			print(url)
		}
		// use coordinate
		else if let coordinate = coordinate {
			url = "https://api.foursquare.com/v2/venues/search?ll=\(coordinate)&query=\(search)\(FourSquareAPIKeys.fourSquareAuthorization)"
			print("coordinate URL:")
			print(url)
		}


		//Network call to get data from foursquare
		Alamofire.request(url).responseJSON { (response) in
			if response.result.isSuccess {
				if let data = response.data {
					do {
						let JSON = try JSONDecoder().decode(FourSquareSearchJSON.self, from: data)
						let venues = JSON.response.venues
						completion(venues)
					}
					catch {print("Error processing data \(error)")}
				}
			}
				//response failed
			else {
				print("Error\(String(describing: response.result.error))")
				let alertController = UIAlertController(title: "No Network Connection", message: "Network connection is not currently available. Please check your connection", preferredStyle: .alert)

				//TODO: NOTIFY USER OF CONNECTION ISSUE
			}
		}
	}
}
