//  SearchAPIClient.swift
//  HereAndThere
//  Created by Winston Maragh on 1/17/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.

import Foundation
import UIKit

//FourSquare Authentication
let fourSquareClientId = "PWWSABHMRSWVYZNHL1QG20A5050WJAI2MIU3AUFWVRQHCITA"
let fourSquareClientSecret = "WFF2451MT2QIYKDCQEXN3ADT5ZKCYQOFIRXPODYUZSSYBSDT"


// MARK: - FourSquare Search API Client
struct SearchAPIClient {
	private init(){}
	static let manager = SearchAPIClient()
	func getVenues(venueSearch: String, latLong: String, completion: @escaping (Error?, [Venue]?) -> Void) {
		let date = 20180117 //TO-DO: change to dateformatter for current date
//		let endpoint = "https://api.foursquare.com/v2/venues/search?ll=\(latLong)=\(venueSearch)&client_id=\(fourSquareClientId)&client_secret=\(fourSquareClientSecret)&v=\(date)"
		let endpoint =  "https://api.foursquare.com/v2/venues/search?ll=41.8510327171934,-87.6335429433757&query=chinese&client_id=PWWSABHMRSWVYZNHL1QG20A5050WJAI2MIU3AUFWVRQHCITA&client_secret=WFF2451MT2QIYKDCQEXN3ADT5ZKCYQOFIRXPODYUZSSYBSDT&v=20180117"
		guard let url = URL(string: endpoint) else {return}

		let task =  URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
			if let error = error {completion(error, nil)}
			else if let data = data {
				do {
					let searchResponse = try JSONDecoder().decode(SearchJSONResponse.self, from: data)
					let venues = searchResponse.response.venues

					print(); print("Venues:"); print(venues); print()
					if venues.isEmpty { completion(nil, nil) }
					completion(nil, venues)
				}
				catch {print("FourSquare Search API call failed - Decoding Error: \(error)")}
			}
		})
		task.resume()
	}
	func getVenues(venueSearch: String, near: String, completion: @escaping (Error?, [Venue]?) -> Void) {
		let date = 20180117 //change to dateformatter for current date
//		let endpoint = "https://api.foursquare.com/v2/venues/search?near=\(near)&query=\(venueSearch)&client_id=\(fourSquareClientId)&client_secret=\(fourSquareClientSecret)&v=\(date)"
		let endpoint = "https://api.foursquare.com/v2/venues/search?near=Brooklyn&query=Coffee&client_id=PWWSABHMRSWVYZNHL1QG20A5050WJAI2MIU3AUFWVRQHCITA&client_secret=WFF2451MT2QIYKDCQEXN3ADT5ZKCYQOFIRXPODYUZSSYBSDT&v=20180117"
		guard let url = URL(string: endpoint) else {return}

		let task =  URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
			if let error = error {completion(error, nil)}
			else if let data = data {
				do {
					let searchResponse = try JSONDecoder().decode(SearchJSONResponse.self, from: data)
					let venues = searchResponse.response.venues
					completion(nil, venues)
				}
				catch {print("FourSquare Search API call failed - Decoding Error: \(error)")}
			}
		})
		task.resume()
	}
}


