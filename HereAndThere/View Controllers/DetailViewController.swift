//  DetailViewController.swift
//  HereAndThere
//  Created by C4Q on 1/16/18.
//  Copyright © 2018 HereAndThere. All rights reserved.

import UIKit

class DetailViewController: UIViewController {

    var detailedView = DetailedView()
    private var venue: Venue!
    
    lazy var addButton: UIBarButtonItem = {
        let addButton = UIBarButtonItem()
        addButton.image = #imageLiteral(resourceName: "plus")
        return addButton
    }()
    
	// MARK: View Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
        view.addSubview(detailedView)
		self.view.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.9, alpha: 1.0)
		configureNavBar()
	}
    
    //Custom Initializer
    init(venue: Venue) {
        super.init(nibName: nil, bundle: nil)
        self.venue = venue
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK :
    private func configureNavBar() {
        navigationItem.title = venue.name
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = addButton
        addButton.action = #selector(addButtonTapped)
        
}
    @objc func addButtonTapped() {
        let vc = CreateTipViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    

}
