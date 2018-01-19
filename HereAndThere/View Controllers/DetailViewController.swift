//  DetailViewController.swift
//  HereAndThere
//  Created by C4Q on 1/16/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.

import UIKit

class DetailViewController: UIViewController {

	// create instance of custom View
	let detailView = DetailView()

	//MARK: Properties
		private var venue: Venue!

	//Initializer
	init(venue: Venue){
		super.init(nibName: nil, bundle: nil)
				self.venue = venue //set weather property
				detailView.configureDetailview(venue: venue, image: #imageLiteral(resourceName: "placeholder-image"))
	}
	//Setup Nib - 'required' initializer 'init(coder:)' must be provided by subclass of 'UIViewController'
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
		super.init(nibName: nibNameOrNil, bundle: nil)
	}
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	//MARK: View Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.clear
		view.addSubview(detailView) //add customView
		setupUI()
		createDismissButton()
	}
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
	}

	//MARK: Methods
	private func setupUI(){
		navigationItem.title = "Venue Detail"
		detailView.configureDetailview(venue: venue, image: #imageLiteral(resourceName: "placeholder-image")) //use once venue model and image is working
	}
	private func createDismissButton(){
		detailView.dismissViewButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
		detailView.dismissButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
	}
	@objc func dismissView() {
		dismiss(animated: true, completion: nil)
	}

	//TO-DO
//	func makeAPhoneCall(phoneNumber: String)  {
//		if let url = URL(string: "tel://\(phoneNumber)") {
//			UIApplication.shared.openURL(url)
//		}
//	}



	//TO-DO
//	Directions
//	MKDirectionsRequest
	//MKRoute
//	MKMapViewDelegate
//	 -- delegate for didSelect


}


