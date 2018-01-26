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
        setAllLabelText()
    }
    
    func setAllLabelText() {
        detailView.imageView.image = image
        detailView.venueNameLabel.text = venue.name
        detailView.venueLocationLabel.text = " \(venue.location.address ?? "n/a"), \(venue.location.city ?? "n/a"), \(venue.location.postalCode ?? "n/a")"
        //detailView.contactButton.titleLabel?.text = venue.contact.formattedPhone
        detailView.contactButton.setTitle(venue.contact.formattedPhone, for: .normal)
        detailView.urlButton.titleLabel?.text = venue.url
    }
}

