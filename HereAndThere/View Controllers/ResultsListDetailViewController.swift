//
//  ResultsListDetailViewController.swift
//  HereAndThere
//
//  Created by C4Q on 1/24/18.
//  Copyright © 2018 HereAndThere. All rights reserved.
//

import UIKit

class ResultsListDetailViewController: UIViewController {
    
    //create an instance of my view
    var detailView = ResultsListDetailView()
    
    var venue: Venue!
    var image: UIImage!
    
    convenience init(venue: Venue, image: UIImage) {
        self.init(nibName: nil, bundle: nil)
        self.venue = venue
        self.image = image
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        view.addSubview(detailView)
        setLabelText()
    }
    
    func venuelabel(){
        detailView.venueNameLabel.text = venue.name
    }

    func setLabelText() {
        detailView.imageView.image = image
    }
    
}
