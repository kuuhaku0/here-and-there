//
//  AddTipCollectionViewCell.swift
//  HereAndThere
//
//  Created by Reiaz Gafar on 1/22/18.
//  Copyright © 2018 HereAndThere. All rights reserved.
//

import UIKit

class AddTipCollectionViewCell: UICollectionViewCell {
    
    lazy var venueImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private func setupVenueImageView() {
        addSubview(venueImageView)
        venueImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            venueImageView.topAnchor.constraint(equalTo: topAnchor),
            venueImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            venueImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            venueImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .green
        return button
    }()
    
    private func setupAddButton() {
        addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: venueImageView.centerXAnchor),
            addButton.centerYAnchor.constraint(equalTo: venueImageView.centerYAnchor)
            ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupVenueImageView()
        setupAddButton()
    }
    

    
}
