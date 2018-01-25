//  SearchCVCell.swift
//  HereAndThere
//  Created by Winston Maragh on 1/16/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.

import UIKit
//import MaterialComponents.MDCCollectionViewCell
import UIKit

//Custom CollectionView Cell for SearchViewController
class SearchCVCell: UICollectionViewCell {

	// MARK: - Create elements in Cell
	lazy var imageView: UIImageView = {
		let imageV = UIImageView() //default image
		imageV.image = #imageLiteral(resourceName: "placeholder-image")
		imageV.backgroundColor = UIColor.clear
		return imageV
	}()
	lazy var nameLabel: UILabel = {
		let label = UILabel()
		label.text = "Name" //default
		label.textAlignment = .left
		label.textColor = UIColor.black
		label.font = UIFont.systemFont(ofSize: 14, weight: .light)
		return label
	}()
	lazy var categoryLabel: UILabel = {
		let label = UILabel()
		label.text = "Category" //default
		label.textAlignment = .left
		label.textColor = UIColor.gray
		label.font = UIFont.systemFont(ofSize: 12, weight: .light)
		return label
	}()
	lazy var addressLabel: UILabel = {
		let label = UILabel()
		label.text = "Address" //default
		label.textAlignment = .left
		label.textColor = UIColor.black
		label.font = UIFont.systemFont(ofSize: 12, weight: .light)
		return label
	}()
	lazy var phoneLabel: UILabel = {
		let label = UILabel()
		label.text = "Phone" //default
		label.textAlignment = .left
		label.textColor = UIColor.black
		label.font = UIFont.systemFont(ofSize: 12, weight: .light)
		return label
	}()




	// MARK: - Setup elements in Cell
	override init(frame: CGRect){
		super.init(frame: UIScreen.main.bounds)
		addImageView()
		imageView.layer.masksToBounds = true
		addNameLabel()
		addCategoryLabel()
		addAddressLabel()
		addPhoneLabel()

	}
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}


	// MARK: - Add elements & layout constraints to Cell
	private func addImageView(){
		addSubview(imageView)
		imageView.translatesAutoresizingMaskIntoConstraints = false
//		imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
//		imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
		imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
//		imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9).isActive = true
		imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true
		imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
	}
	private func addNameLabel(){
		addSubview(nameLabel)
		nameLabel.translatesAutoresizingMaskIntoConstraints = false
		nameLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
		nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5).isActive = true
//		nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6).isActive = true
//		nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//		nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
	}
	private func addCategoryLabel(){
		addSubview(categoryLabel)
		categoryLabel.translatesAutoresizingMaskIntoConstraints = false
		categoryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
		categoryLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5).isActive = true
//		categoryLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6).isActive = true
	}
	private func addAddressLabel(){
		addSubview(addressLabel)
		addressLabel.translatesAutoresizingMaskIntoConstraints = false
		addressLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor).isActive = true
		addressLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5).isActive = true
//		addressLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6).isActive = true
	}
	private func addPhoneLabel(){
		addSubview(phoneLabel)
		phoneLabel.translatesAutoresizingMaskIntoConstraints = false
		phoneLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor).isActive = true
		phoneLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5).isActive = true
//		starsLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
	}

}
