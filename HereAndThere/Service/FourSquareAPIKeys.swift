//  FourSquareAPIKeys.swift
//  HereAndThere
//  Created by Winston on 1/22/18.
//  Copyright © 2018 HereAndThere. All rights reserved.

import Foundation

//git Ignore
struct FourSquareAPIKeys {
	static let CLIENT_ID = "ASLASQKJYNMWXLNPILANMLIQVOS2H5PEJIW005LWOZZ51BRH"
	static let CLIENT_SECRET = "VSAUR1RVSKGYIT3SK43I3EEJP31XLD2ESQ22QZKB5OGCTRJB"
	static let todaysDate = Date().description.prefix(10).replacingOccurrences(of: "-", with: "")
	static let fourSquareAuthorization = "&client_id=\(FourSquareAPIKeys.CLIENT_ID)&client_secret=\(FourSquareAPIKeys.CLIENT_SECRET)&v=\(FourSquareAPIKeys.todaysDate)"
}


fileprivate struct ReiazKeys {
    static let clientID = "ASLASQKJYNMWXLNPILANMLIQVOS2H5PEJIW005LWOZZ51BRH"
    static let clientSecret = "VSAUR1RVSKGYIT3SK43I3EEJP31XLD2ESQ22QZKB5OGCTRJB"
}


