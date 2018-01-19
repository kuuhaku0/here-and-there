//  NetworkHelper.swift
//  HereAndThere
//  Created by Winston Maragh on 1/17/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.


import Foundation
import UIKit

//Image Helper - get images from online
//struct ImageHelper {
//    private init() {}
//    static let manager = ImageHelper()
//
//    func getImage(from urlStr: String,
//                                completionHandler: @escaping (UIImage) -> Void,
//                                errorHandler: @escaping (AppError) -> Void) {
//
//        guard let url = URL(string: urlStr) else { errorHandler(.badURL); return}
//
//        //Check if data already exists
////        if let savedImage = FileManagerHelper.manager.getUIImage(with: urlStr) {
////            completionHandler(savedImage)
////            return
////        }
//
//        //Do completion only on first run, if it already exist do nothing.
//        let completion: (Data) -> Void = {(data: Data) in
//            guard let onlineImage = UIImage(data: data) else {return}
//            //Save Image to FileManager
////            FileManagerHelper.manager.saveUIImage(with: urlStr, image: onlineImage)
//            completionHandler(onlineImage) //call completionHandler
//        }
//        NetworkHelper.manager.performDataTask(withURL: url, completionHandler: completion, errorHandler: errorHandler)
//    }
//}


