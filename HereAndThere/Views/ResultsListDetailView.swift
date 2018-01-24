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

    //set up my objects
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    //name
    lazy var venueNameLabel: UILabel = {
        let label = UILabel()
        label.text = "hello"
        label.textAlignment = .center
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
    lazy var contactLabel: UILabel = {
        let label = UILabel()
        label.text = "4678468345"
        label.textAlignment = .center
        return label
    }()
    
    //url
    lazy var urlLabel: UILabel = {
        let label = UILabel()
        label.text = "4678468345"
        label.textAlignment = .center
        return label
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
        backgroundColor = .yellow
        
    }
    
    func setViews(){
        //add all the views I'm setting up
        setImageView()
        setVenueNameLabel()
        setLocationNameLabel()
        setContactLabel()
        setUrlLabel()
    }
    
    func setImageView() {
        addSubview(imageView)
        imageView.snp.makeConstraints{(make) in
            let safeArea = safeAreaLayoutGuide
            make.size.equalTo(200)
            make.centerX.equalTo(safeArea)
            
        }
    }
    
    func setVenueNameLabel() {
        addSubview(venueNameLabel)
    }
    
    func setLocationNameLabel() {
        addSubview(venueLocationLabel)
    }
    
    func setContactLabel() {
        addSubview(contactLabel)
    }
    
    func setUrlLabel() {
        addSubview(urlLabel)
    }

}
