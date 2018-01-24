//
//  DetailedView.swift
//  HereAndThere
//
//  Created by Ashlee Krammer on 1/22/18.
//  Copyright © 2018 HereAndThere. All rights reserved.
//

import UIKit
import SnapKit

class DetailedView: UIView {

    //large title
    //picture
    
    lazy var imageView: UIImageView = {
        let imageV = UIImageView() //default image
        imageV.image = #imageLiteral(resourceName: "placeholder-image")
        imageV.contentMode = .scaleAspectFill
        imageV.backgroundColor = UIColor.clear
        return imageV
    }()
    
    //type of place label
    lazy var placeLabel: UILabel = {
       let label = UILabel()
        label.text = "Place Label"
        return label
    }()
    
    //notes label
    lazy var notesLabel: UILabel = {
        let label = UILabel()
        label.text = "Notes Label"
        return label
    }()
    
//    lazy var navButton: UINavigationItem = {
//       let navButton = UINavigationItem()
//        navButton.rightBarButtonItem?.image = #imageLiteral(resourceName: "plus")
//        return navButton
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setUpView() {
        setUpImage()
        setUpNotesLabel()
        setUpPlaceLabel()
    }
    
    

    
    func setUpImage() {
        addSubview(imageView)
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
//        imageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
//        imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
//        imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.65).isActive = true
        //        imageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        //    }
        
        imageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.left.equalTo(safeAreaLayoutGuide).offset(8)
            make.right.equalTo(safeAreaLayoutGuide).offset(-8)
            make.height.equalTo(self).multipliedBy(0.65)
        }
    }
    
    func setUpPlaceLabel() {
        addSubview(placeLabel)
//        placeLabel.translatesAutoresizingMaskIntoConstraints = false
//        placeLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
//        placeLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
//        placeLabel.bottomAnchor.constraint(equalTo: notesLabel.topAnchor).isActive = true
//        placeLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        placeLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(imageView).offset(10)
            make.left.equalTo(safeAreaLayoutGuide).offset(8)
            make.right.equalTo(safeAreaLayoutGuide).offset(-8)
        }
    }
    
    func setUpNotesLabel() {
        addSubview(notesLabel)
//        notesLabel.translatesAutoresizingMaskIntoConstraints = false
//        notesLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
//        notesLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
//        notesLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
//        notesLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        notesLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(placeLabel).offset(5)
            make.left.equalTo(safeAreaLayoutGuide).offset(8)
            make.right.equalTo(safeAreaLayoutGuide).offset(-8)
        }
    }

}
