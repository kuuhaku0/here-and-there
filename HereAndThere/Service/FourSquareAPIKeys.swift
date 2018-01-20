//  APIKeys.swift
//  HereAndThere
//  Created by C4Q on 1/19/18.
//  Copyright © 2018 HereAndThere. All rights reserved.

import Foundation

//git Ignore
struct FourSquareAPIKeys {
	static let CLIENT_ID = "XQ2NEZC5REJV4O0LWRYVJIMBKSKFAFQA0VOU35QXBKCZQJ2M"
	static let CLIENT_SECRET = "4B2VHJ252UR4VLVJGNT3IAHJTQ5VC0MX0HKHVE24FFMQNOGY"
	static let todaysDate = Date().description.prefix(10).replacingOccurrences(of: "-", with: "")
	static let fourSquareAuthorization = "&client_id=\(FourSquareAPIKeys.CLIENT_ID)&client_secret=\(FourSquareAPIKeys.CLIENT_SECRET)&v=\(FourSquareAPIKeys.todaysDate)"
}
