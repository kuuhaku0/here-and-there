////////////////////////////////////////////
//
//  ResultsListDetailView.swift
//  HereAndThere
//
//  Created by C4Q on 1/24/18.
//  Copyright © 2018 HereAndThere. All rights reserved.
//

import UIKit
import SnapKit

class ResultsListDetailView: UIView {
    
    //TODO: Fix visual stuff, text syle, hover shade
    
    //set up my objects
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 20
        return image
    }()
    
    //name
    lazy var venueNameLabel: UILabel = {
        let label = UILabel()
        label.text = "hello"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        return label
    }()
    
    //location
    lazy var venueLocationLabel: UILabel = {
        let label = UILabel()
        label.text = "hello"
        label.textAlignment = .center
        return label
    }()
    
    //contact
    lazy var contactButton: UIButton = {
        let button = UIButton()
        button.setTitle("Call", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    //url
    lazy var urlButton: UIButton = {
        let button = UIButton()
        button.setTitle("www.dfjbk.com", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    
    //MUST HAVE THE REQUIRED INIT IN EVERY VIEW!
    //Its used when its story board
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    //MUST ALWAYS HAVE THIS FUNC TOO!This function runs at the start of the view when it being initialized. Basically like view did load but for views
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setViews()
        backgroundColor = .white
        
    }
    
    func setViews(){
        //add all the views I'm setting up
        setImageView()
        setVenueNameLabel()
        setLocationNameLabel()
        setContactButton()
        //setUrlButton()
    }
    
    func setImageView() {
        addSubview(imageView)
        imageView.snp.makeConstraints{(make) in
            let safeArea = safeAreaLayoutGuide
            make.size.equalTo(350)
            make.top.equalTo(safeArea).inset(40)
            make.centerX.equalTo(safeArea)
            
        }
    }
    
    func setVenueNameLabel() {
        addSubview(venueNameLabel)
        let safeArea = safeAreaLayoutGuide
        venueNameLabel.snp.makeConstraints{(make) in
            make.width.equalTo(safeArea)
            make.top.equalTo(imageView).offset(400)
            make.centerX.equalTo(safeArea)
        }
    }
    
    func setLocationNameLabel() {
        addSubview(venueLocationLabel)
        let safeArea = safeAreaLayoutGuide
        venueLocationLabel.snp.makeConstraints{(make) in
            make.top.equalTo(venueNameLabel).offset(30)
            make.centerX.equalTo(safeArea)
        }
    }
    func setUrlButton() {
        addSubview(urlButton)
        urlButton.snp.makeConstraints{(make) in
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-30)
        }
    }
    
    func setContactButton() {
        addSubview(contactButton)
        contactButton.snp.makeConstraints{(make) in
            make.centerX.equalTo(snp.centerX)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }
    
    
    
    
}
