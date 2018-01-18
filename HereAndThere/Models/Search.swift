//  Search.swift
//  HereAndThere
//  Created by Winston Maragh on 1/17/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.

import Foundation

// MARK: FourSquare Search Json
struct SearchJSONResponse: Codable {
	let response: SearchResponse
}

struct SearchResponse: Codable {
	let venues: [Venue]
}

struct Venue: Codable {
	let id: String
	let name: String
	let contact: Contact
	let location: Location
	let categories: [Category]
//	let verified: Bool
//	let stats: Stats
//	let allowMenuURLEdit: Bool?
//	let beenHere: BeenHere
//	let specials: Specials
//	let hereNow: HereNow
//	let venueChains: [VenueChain]
//	let url: String?
//	let hasMenu: Bool?
//	let menu: Menu?
//	let delivery: Delivery?
	//added property
	var imageStr: String?
}

struct Contact:  Codable {
	let phone: String?
	let formattedPhone: String?
//	let twitter: String?
}

struct Location: Codable {
	let address: String?
	let crossStreet: String?
	let lat: Double
	let lng: Double
	let distance: Double?
	let postalCode: String?
//	let cc: Cc
//	let city: City?
//	let state: State
//	let country: Country
	let formattedAddress: [String] //[0]
}

struct Category: Codable {
	let id: String
	let name: String
	let pluralName: String
	let shortName: String
//	let icon: Icon
	let primary: Bool
}
//struct Icon: Codable {
//	let purplePrefix: String
//	let suffix: Suffix
//	enum Suffix: String, Codable {
//		case png = ".png"
//	}
//}

//struct Stats: Codable {
//	let checkinsCount: Double
//	let usersCount: Double
//	let tipCount: Double
//}

//struct BeenHere: Codable {
//	let lastCheckinExpiredAt: Double
//}

//struct Specials: Codable {
//	let count: Double
//	let items: [JSONAny]
//}

//struct HereNow: Codable {
//	let count: Double
//	let summary: Summary
//	let groups: [JSONAny]
//}

//struct Delivery: Codable {
//	let id: String
//	let url: String
//	let provider: Provider
//}

//
//struct Provider: Codable {
//	let name: String
//}

//enum Summary: String, Codable {
//	case nobodyHere = "Nobody here"
//}

//
//enum Cc: String, Codable {
//	case us = "US"
//}

//enum City: String, Codable {
//	case chicago = "Chicago"
//	case westmont = "Westmont"
//}

//struct LabeledLatLng: Codable {
//	let label: LabeledLatLngLabel
//	let lat: Double
//	let lng: Double
//}

//struct Menu: Codable {
//	let type: MenuLabel
//	let label: MenuLabel
//	let anchor: Anchor
//	let url: String
//	let mobileURL: String
//	let externalURL: String?
//}

//struct VenueChain: Codable {
//	let id: String
//}

