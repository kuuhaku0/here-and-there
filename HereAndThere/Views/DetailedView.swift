//
//  DetailedView.swift
//  HereAndThere
//
//  Created by Ashlee Krammer on 1/22/18.
//  Copyright © 2018 HereAndThere. All rights reserved.
//

import UIKit

class DetailedView: UIView {

    //large title
    //picture
    
    lazy var imageView: UIImageView = {
        let imageV = UIImageView() //default image
        imageV.image = #imageLiteral(resourceName: "placeholder-image")
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
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setUpView() {
        setUpImage()
        setUpPlaceLabel()
        setUpNotesLabel()
    }
    
    
    func setUpImage() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        imageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
    }
    
    func setUpPlaceLabel() {
        addSubview(placeLabel)
        placeLabel.translatesAutoresizingMaskIntoConstraints = false
        placeLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        placeLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        placeLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
    }
    
    func setUpNotesLabel() {
        addSubview(notesLabel)
        notesLabel.translatesAutoresizingMaskIntoConstraints = false
        notesLabel.topAnchor.constraint(equalTo: placeLabel.bottomAnchor).isActive = true
        notesLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        notesLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true 
        
    }

}
