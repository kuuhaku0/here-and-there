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
    
	private let date = Date().description.prefix(10).replacingOccurrences(of: "-", with: "")

	func getVenues(from search: String, coordinate: String, near: String, completion: @escaping ([Venue]) -> Void) {

//			var FOURSQUARE_URL = ""
//			if near == "" {
//				FOURSQUARE_URL = "https://api.foursquare.com/v2/venues/search?ll=\(coordinate)&query=\(search)\(FourSquareAPIKeys.fourSquareAuthorization)"
//			} else {
//				FOURSQUARE_URL = "https://api.foursquare.com/v2/venues/search?near=\(near)&query=\(search)\(FourSquareAPIKeys.fourSquareAuthorization)"
//			}

		var criteria = ""
		if near != "" { criteria = "near=\(near)"}
		else {criteria = "ll=\(coordinate)"}
		var FOURSQUARE_URL = "https://api.foursquare.com/v2/venues/search?\(criteria)&query=\(search)\(FourSquareAPIKeys.fourSquareAuthorization)"

			//Network call to get data from foursquare
			Alamofire.request(FOURSQUARE_URL).responseJSON { (response) in
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
                //TODO: NOTIFY USER OF CONNECTION ISSUE
				}
			}
    }
}


