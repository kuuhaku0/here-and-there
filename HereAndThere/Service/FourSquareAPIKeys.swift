//  FourSquareAPIKeys.swift
//  HereAndThere
//  Created by Winston on 1/22/18.
//  Copyright © 2018 HereAndThere. All rights reserved.

import Foundation

//git Ignore
struct FourSquareAPIKeys {
	static let CLIENT_ID = "1ARUA4GY1EFGGPPBIHLSO25W0L4CMYWR15MFGI1L15X3DUTG"
	static let CLIENT_SECRET = "BDF2YZASPV2YKUQL2LJRI2SQYM23MZIPG3RKFGE4XOPK0KIY"
	static let todaysDate = Date().description.prefix(10).replacingOccurrences(of: "-", with: "")
	static let fourSquareAuthorization = "&client_id=\(FourSquareAPIKeys.CLIENT_ID)&client_secret=\(FourSquareAPIKeys.CLIENT_SECRET)&v=\(FourSquareAPIKeys.todaysDate)"
}

fileprivate struct KanizKey {
    static let CLIENT_ID = "1ARUA4GY1EFGGPPBIHLSO25W0L4CMYWR15MFGI1L15X3DUTG"
    static let CLIENT_SECRET = "BDF2YZASPV2YKUQL2LJRI2SQYM23MZIPG3RKFGE4XOPK0KIY"
    static let todaysDate = Date().description.prefix(10).replacingOccurrences(of: "-", with: "")
    static let fourSquareAuthorization = "&client_id=\(FourSquareAPIKeys.CLIENT_ID)&client_secret=\(FourSquareAPIKeys.CLIENT_SECRET)&v=\(FourSquareAPIKeys.todaysDate)"
}
