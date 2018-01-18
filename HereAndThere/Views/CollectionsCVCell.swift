//  CollectionsCVCell.swift
//  HereAndThere
//  Created by Winston Maragh on 1/17/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.

import UIKit

//Custom CollectionView Cell for CollectionsViewController
class CollectionsCVCell: UICollectionViewCell {

	// MARK: - Create elements in Cell
	lazy var imageView: UIImageView = {
		let imageV = UIImageView() //default image
		imageV.image = #imageLiteral(resourceName: "placeholder-image")
		imageV.backgroundColor = UIColor.clear
		return imageV
	}()


	// MARK: - Setup elements in Cell
	override init(frame: CGRect){
		super.init(frame: UIScreen.main.bounds)
		addImageView()
		imageView.layer.masksToBounds = true
	}
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}


	// MARK: - Add elements & layout constraints to Cell
	func addImageView(){
		addSubview(imageView)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
	}
}
