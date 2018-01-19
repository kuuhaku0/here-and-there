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
    private let CLIENT_ID = "XQ2NEZC5REJV4O0LWRYVJIMBKSKFAFQA0VOU35QXBKCZQJ2M"
    private let CLIENT_SECRET = "4B2VHJ252UR4VLVJGNT3IAHJTQ5VC0MX0HKHVE24FFMQNOGY"

    func getVenues(from search: String, latLong: String, near: String, completion: @escaping ([Venue]) -> Void) {
        
        var FOURSQUARE_URL = ""
        
        if near == "" {
            FOURSQUARE_URL = "https://api.foursquare.com/v2/venues/search?ll=\(latLong)&query=\(search)&client_id=\(CLIENT_ID)&client_secret=\(CLIENT_SECRET)&v=\(date)"
        } else {
            FOURSQUARE_URL = "https://api.foursquare.com/v2/venues/search?near=\(near)&query=\(search)&client_id=\(CLIENT_ID)&client_secret=\(CLIENT_ID)&v=\(date)"
        }
        
        //Network call to get data from foursquare
        Alamofire.request(FOURSQUARE_URL).responseJSON { (response) in
            if response.result.isSuccess {
                if let data = response.data {
                    do {
                        let JSON = try JSONDecoder().decode(SearchJSONResponse.self, from: data)
                        let response = JSON.response
                        let venues = response.venues
                        completion(venues)
                    }
                    catch {
                        print("Error processing data \(error)")
                    }
                }
            } else {
                print("Error\(String(describing: response.result.error))")
                //TODO: NOTIFY USER OF CONNECTION ISSUE
            }
        }
    }
}


