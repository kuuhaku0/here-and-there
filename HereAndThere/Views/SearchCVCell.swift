//  SearchCVCell.swift
//  HereAndThere
//  Created by Winston Maragh on 1/16/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.

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
		label.text = "default Name" //default
		label.textAlignment = .center
		label.textColor = UIColor.blue
		return label
	}()


	// MARK: - Setup elements in Cell
	override init(frame: CGRect){
		super.init(frame: UIScreen.main.bounds)
		addImageView()
		addNameLabel()
		imageView.layer.masksToBounds = true
	}
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	
	// MARK: - Add elements & layout constraints to Cell
	private func addImageView(){
		addSubview(imageView)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.80).isActive = true
	}
	private func addNameLabel(){
		addSubview(nameLabel)
		nameLabel.translatesAutoresizingMaskIntoConstraints = false
		nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
		nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
	}

}


