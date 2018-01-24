//  FourSquareAPIKeys.swift
//  HereAndThere
//  Created by Winston on 1/22/18.
//  Copyright © 2018 HereAndThere. All rights reserved.

import Foundation

//git Ignore
struct FourSquareAPIKeys {
    static let CLIENT_ID = "XQ2NEZC5REJV4O0LWRYVJIMBKSKFAFQA0VOU35QXBKCZQJ2M"
    static let CLIENT_SECRET = "4B2VHJ252UR4VLVJGNT3IAHJTQ5VC0MX0HKHVE24FFMQNOGY"
//    static let CLIENT_ID = "YL1MVQQTIEUITXY4L5CNDWUD53GJYBSQKZWLORVGVQ41NYKT"
//    static let CLIENT_SECRET = "HB3MNM0SFNC1EUYKNBO1VI4IM20RX1IEIA2GDNCZENLGZTRQ"
	static let todaysDate = Date().description.prefix(10).replacingOccurrences(of: "-", with: "")
	static let fourSquareAuthorization = "&client_id=\(FourSquareAPIKeys.CLIENT_ID)&client_secret=\(FourSquareAPIKeys.CLIENT_SECRET)&v=\(FourSquareAPIKeys.todaysDate)"
}
