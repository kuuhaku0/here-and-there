//  DetailViewController.swift
//  HereAndThere
//  Created by C4Q on 1/16/18.
//  Copyright © 2018 HereAndThere. All rights reserved.

import UIKit

class DetailViewController: UIViewController {

    
    var detailedView = DetailedView()
    private var venue: Venue!
    private var image: UIImage!
    
    lazy var addButton: UIBarButtonItem = {
        let addButton = UIBarButtonItem()
        addButton.image = #imageLiteral(resourceName: "plus")
        return addButton
    }()
    
	// MARK: View Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
        view.addSubview(detailedView)
        view.backgroundColor = .white
		configureNavBar()
        configureDetailedVC()
        detailedView.imageView.image = image
	}
    
    //Custom Initializer
    init(venue: Venue, image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.venue = venue
        self.image = image
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK :
    private func configureNavBar() {
        navigationItem.title = venue.name
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = addButton
}
    private func configureDetailedVC() {
        detailedView.placeLabel.text = venue.categories[0].name
        detailedView.notesLabel.text = ""
    }


}
