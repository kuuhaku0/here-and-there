//  ImageCache.swift
//  HereAndThere
//  Created by Winston Maragh on 1/17/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.

import UIKit

class ImageCache {
	private init(){}

	static let manager = ImageCache()

	private var sharedCached = NSCache<NSString, UIImage>()

	// get current cached image
	func getImageFromCache(url: URL) -> UIImage? {
		return sharedCached.object(forKey: url.absoluteString as NSString)
	}

	// process image and store in cache
	func saveImageToCache(imageURL: URL, completion: @escaping(Error?, UIImage?) -> Void) {
		DispatchQueue.global().async {
			do {
				let imageData = try Data.init(contentsOf: imageURL)
				let image  = UIImage.init(data: imageData)

				// store image in cache
				if let image = image {
					self.sharedCached.setObject(image, forKey: imageURL.absoluteString as NSString)
				}

				completion(nil, image)
			} catch {
				print("ImageCache - image processing error: \(error.localizedDescription)")
				completion(error, nil)
			}
		}
	}
}
