//  SearchCVCell.swift
//  HereAndThere
//  Created by Winston Maragh on 1/16/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.

import UIKit
import MaterialComponents.MDCCollectionViewCell
import UIKit

//Custom CollectionView Cell for SearchViewController
class SearchCVCell: MDCCollectionViewCell {

	// MARK: - Create elements in Cell
	lazy var imageView: UIImageView = {
		let imageV = UIImageView() //default image
		imageV.image = #imageLiteral(resourceName: "placeholder-image")
        imageV.contentMode = .scaleAspectFill
		imageV.backgroundColor = UIColor.clear
        imageV.clipsToBounds = true
        imageV.layer.masksToBounds = true
		return imageV
	}()
	lazy var nameLabel: UILabel = {
		let label = UILabel()
        label.backgroundColor = .white
		label.text = "default Name" //default
		label.textAlignment = .center
        label.layer.masksToBounds = true
		return label
	}()


	// MARK: - Setup elements in Cell
	override init(frame: CGRect){
		super.init(frame: UIScreen.main.bounds)
		addNameLabel()
        addImageView()

//        imageView.layer.masksToBounds = true
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
		imageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7).isActive = true
        imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
	}
	private func addNameLabel(){
		addSubview(nameLabel)
		nameLabel.translatesAutoresizingMaskIntoConstraints = false
		nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
	}

}
