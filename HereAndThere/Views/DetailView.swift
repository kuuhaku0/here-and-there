//  DetailView.swift
//  HereAndThere
//  Created by C4Q on 1/16/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.

import UIKit

//Custom View for overall Layout of DetailViewController (PopOut)
class DetailView: UIView {

	// MARK: - Create elements in View
	//Structure to contain elements
	lazy var containerView: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		view.layer.cornerRadius = 20
		view.layer.masksToBounds = true
		return view
	}()
	lazy var dismissViewButton: UIButton = {
		let button = UIButton(frame: UIScreen.main.bounds)
		button.backgroundColor = .clear
		return button
	}()
	lazy var dismissButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage(named: "cancel"), for: .normal)
		return button
	}()
	//elements in View
	lazy var venueImageView: UIImageView = {
		let iv = UIImageView()
		iv.contentMode = .scaleToFill
		iv.image = UIImage(named: "blurredBG2.jpg")
		iv.backgroundColor = .clear
		return iv
	}()
	lazy var spinner: UIActivityIndicatorView = {
		let aiv = UIActivityIndicatorView()
		aiv.startAnimating()
		return aiv
	}()
	lazy var venueNameLabel: UILabel = {
		let lbl = UILabel()
		lbl.textAlignment = .center
		lbl.font = UIFont.systemFont(ofSize: 22, weight: .bold)
		lbl.textColor = UIColor.blue
		return lbl
	}()
	lazy var categoryTitleLabel: UILabel = {
		let lbl = UILabel()
		lbl.textAlignment = .center
		lbl.font = UIFont.systemFont(ofSize: 18, weight: .regular)
		lbl.textColor = UIColor.gray
		return lbl
	}()
	lazy var addressLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
		return label
	}()
	lazy var phoneLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
		return label
	}()

	//TO DO: ADD
	//make phone number text clickable - calls up phone call
	//menu (scrollable view or image View)
	//pictures of food (Photo Library or horizontal collection View or imageView)


	// MARK: - Setup elements in View
	override init(frame: CGRect){
		super.init(frame: UIScreen.main.bounds)
		commonInit()
	}
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}
	private func commonInit() {
		backgroundColor = .clear
		setupViews()
	}
	override func layoutSubviews() {
		//laid out screen
		super.layoutSubviews()
		venueImageView.layer.masksToBounds = true
	}
	func setupViews() {
		setupContainerView()
		setupDismissView()
		setupDismissbutton()

		addVenueImageView(); addSpinner()
		addVenueNameLabel()
		addCategoryTitleLabel()
		addAddressLabel()
		addPhoneLabel()
	}


	// MARK: - Add elements & layout constraints to View
	private func setupDismissView() {
		addSubview(dismissViewButton)
	}
	private func setupContainerView(){
		addSubview(containerView)
		containerView.translatesAutoresizingMaskIntoConstraints = false
		containerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		containerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		containerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.90).isActive = true
		containerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.80).isActive = true
	}
	private func setupDismissbutton() {
		addSubview(dismissButton)
		dismissButton.translatesAutoresizingMaskIntoConstraints = false
		dismissButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16).isActive = true
		dismissButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16).isActive = true
	}

	private func addVenueImageView(){
		addSubview(venueImageView)
		venueImageView.translatesAutoresizingMaskIntoConstraints = false
 		venueImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15).isActive = true
		venueImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.7).isActive = true
		venueImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.35).isActive = true
		venueImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
	}
	private func addSpinner(){
		addSubview(spinner)
		spinner.translatesAutoresizingMaskIntoConstraints = false
		spinner.centerXAnchor.constraint(equalTo: venueImageView.centerXAnchor).isActive = true
		spinner.centerYAnchor.constraint(equalTo: venueImageView.centerYAnchor).isActive = true
	}
	private func addVenueNameLabel() {
		addSubview(venueNameLabel)
		venueNameLabel.translatesAutoresizingMaskIntoConstraints = false
		venueNameLabel.topAnchor.constraint(equalTo: venueImageView.bottomAnchor, constant: 15).isActive = true
		venueNameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
		venueNameLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.7)
		//label already has an intrinsic height
	}
	private func addCategoryTitleLabel() {
		addSubview(categoryTitleLabel)
		categoryTitleLabel.translatesAutoresizingMaskIntoConstraints = false
		categoryTitleLabel.topAnchor.constraint(equalTo: venueNameLabel.bottomAnchor, constant: 15).isActive = true
		categoryTitleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
		categoryTitleLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5)
		//label already has an intrinsic height
	}
	private func addAddressLabel() {
		addSubview(addressLabel)
		addressLabel.translatesAutoresizingMaskIntoConstraints = false
		addressLabel.topAnchor.constraint(equalTo: categoryTitleLabel.bottomAnchor, constant: 15).isActive = true
		addressLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
		addressLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.7).isActive = true
		//height intrinsic size
	}
	private func addPhoneLabel() {
		addSubview(phoneLabel)
		phoneLabel.translatesAutoresizingMaskIntoConstraints = false
		phoneLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 15).isActive = true
		phoneLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
		phoneLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.6).isActive = true
	}

	public func configureDetailview(venue: Venue, image: UIImage) {
		venueImageView.image = #imageLiteral(resourceName: "placeholder-image") //placeholder
		venueNameLabel.text = "Default Venue"
		categoryTitleLabel.text = "default Category"  //placeholder
		addressLabel.text = "123 Main Street" //placeholder
		phoneLabel.text = "123-456-7890" //placeholder
	}
}

