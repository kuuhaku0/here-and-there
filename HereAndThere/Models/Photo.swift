//  Photo.swift
//  HereAndThere
//  Created by Winston Maragh on 1/17/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.

import Foundation

// MARK: FourSquare Photos Json
import Foundation

struct PhotoJSONResponse: Codable {
	let response: PhotoResponse
}

struct PhotoResponse: Codable {
	let photos: Photos
}

struct Photos: Codable {
	let count: Int
	let items: [PhotosItem]
	let dupesRemoved: Int
}

struct PhotosItem: Codable {
	let id: String
	let createdAt: Int
//	let source: Source
//	let purplePrefix: ItemPrefix
	let suffix: String
	let width: Int
	let height: Int
//	let user: User
//	let checkin: Checkin?
//	let visibility: Visibility
//	let tip: Tip?
}

//struct Checkin: Codable {
//	let id: String
//	let createdAt: Int
//	let type: PurpleType
//	let timeZoneOffset: Int
//}
//
//enum PurpleType: String, Codable {
//	case checkin = "checkin"
//}
//
//enum ItemPrefix: String, Codable {
//	case httpsIgx4SqiNetImgGeneral = "https://igx.4sqi.net/img/general/"
//}

//struct Source: Codable {
//	let name: Name
//	let url: URL
//}

//enum Name: String, Codable {
//	case foursquareForAndroid = "Foursquare for Android"
//	case foursquareForIOS = "Foursquare for iOS"
//	case instagram = "Instagram"
//}

//struct Tip: Codable {
//	let id: String
//	let createdAt: Int
//	let text: String
//	let type: String
//	let canonicalURL: String
////	let likes: Likes
//	let like: Bool
//	let logView: Bool
//	let agreeCount: Int
//	let disagreeCount: Int
//	let todo: Todo
//}

//struct Likes: Codable {
//	let count: Int
//	let groups: [JSONAny]
//}

//struct Todo: Hashable, Equatable, Codable {
//	let count: Int
//}
//
//struct User: Codable {
//	let id: String
//	let firstName: String
//	let lastName: String?
//	let gender: String?
//	let photo: Photo
//}


//struct Photo: Codable {
//	let purplePrefix: PhotoPrefix
//	let suffix: String
//
//	enum CodingKeys: String, CodingKey {
//		case purplePrefix = "prefix"
//		case suffix = "suffix"
//	}
//}
//
//enum PhotoPrefix: String, Codable {
//	case httpsIgx4SqiNetImgUser = "https://igx.4sqi.net/img/user/"
//}
//
//enum Visibility: String, Codable {
//	case purplePublic = "public"
//}

