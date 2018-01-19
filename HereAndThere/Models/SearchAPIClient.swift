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
    
    let date = Date().description.prefix(10).replacingOccurrences(of: "-", with: "")
    let CLIENT_ID = "PWWSABHMRSWVYZNHL1QG20A5050WJAI2MIU3AUFWVRQHCITA"
    let CLIENT_SECRET = "WFF2451MT2QIYKDCQEXN3ADT5ZKCYQOFIRXPODYUZSSYBSDT"

    func getVenues(from search: String, latLong: String, near: String) -> [Venue] {
        
        var allVenuesFromSearch = [Venue]() {
            didSet {
                print(allVenuesFromSearch.count)
            }
        }
        
        if near == "" {
            let FOURSQUARE_URL = "https://api.foursquare.com/v2/venues/search?ll=\(latLong)&query=\(search)&client_id=\(CLIENT_ID)&client_secret=\(CLIENT_SECRET)&v=20180117"
            
            Alamofire.request(FOURSQUARE_URL).responseJSON { (response) in
                if response.result.isSuccess {
                    if let data = response.data {
                        do {
                            let JSON = try JSONDecoder().decode(SearchJSONResponse.self, from: data)
                            let response = JSON.response
                            let venues = response.venues
                            allVenuesFromSearch = venues
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
        } else {
            
            let FOURSQUARE_URL = "https://api.foursquare.com/v2/venues/search?near=\(near)&query=\(search)&client_id=\(CLIENT_ID)&client_secret=\(CLIENT_ID)&v=\(date)"
            
            Alamofire.request(FOURSQUARE_URL).responseJSON { (response) in
                if response.result.isSuccess {
                    if let data = response.data {
                        do {
                            let JSON = try JSONDecoder().decode(SearchJSONResponse.self, from: data)
                            let response = JSON.response
                            let venues = response.venues
                            allVenuesFromSearch = venues
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
        return allVenuesFromSearch
    }
}


