//
//  CreateCollectionViewController.swift
//  HereAndThere
//
//  Created by Reiaz Gafar on 1/22/18.
//  Copyright © 2018 HereAndThere. All rights reserved.
//

import UIKit

class CreateTipViewController: UIViewController {

    let createTipView = CreateTipView()
    var venue: Venue!
    var image: UIImage!
    
    convenience init(venue: Venue, image: UIImage) {
        self.init(nibName: nil, bundle: nil)
        self.venue = venue
        self.image = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(createTipView)
        configureNavBar()
    }

    // Function to configure the nav bar
    func configureNavBar() {
        navigationItem.title = "Add to or create collection."
        setupCreateButton()
        setupCancelButton()
    }
    
    // Function to setup a list button on the nav bar
    func setupCreateButton() {
        let createBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: #selector(createButtonTapped))
        navigationItem.rightBarButtonItem = createBarButtonItem
    }
    
    // Function that's called when the list button is tapped
    @objc func createButtonTapped() {
        // TODO:
        if DataPersistenceHelper.manager.addVenueToCollection(collectionName: "", venue: venue, tip: createTipView.tipTextField.text, venueID: venue.id, image: image) {
            print("successfully saved")
        }
    }
    
    // Function to setup a search button on the nav bar
    func setupCancelButton() {
        let cancelBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = cancelBarButtonItem
    }
    
    // Function that's called when the search button is tapped
    @objc func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    
    

}
