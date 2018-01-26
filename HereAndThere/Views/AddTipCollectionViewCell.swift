//
//  AddTipCollectionViewCell.swift
//  HereAndThere
//
//  Created by Reiaz Gafar on 1/22/18.
//  Copyright © 2018 HereAndThere. All rights reserved.
//

import UIKit

class AddTipCollectionViewCell: UICollectionViewCell {
    
    lazy var collectionNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    
    private func setupCollectionNameLabel() {
        addSubview(collectionNameLabel)
        collectionNameLabel.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(self.snp.bottom)
            maker.leading.equalTo(self.snp.leading)
            maker.trailing.equalTo(self.snp.trailing)
            maker.height.equalTo(25)
        }
    }
    
    lazy var venueImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private func setupVenueImageView() {
        addSubview(venueImageView)
        venueImageView.translatesAutoresizingMaskIntoConstraints = false
        venueImageView.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top)
            make.leading.equalTo(snp.leading)
            make.trailing.equalTo(snp.trailing)
            make.bottom.equalTo(collectionNameLabel.snp.top)
        }
        
        
//        NSLayoutConstraint.activate([
//            venueImageView.topAnchor.constraint(equalTo: topAnchor),
//            venueImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            venueImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            venueImageView.bottomAnchor.constraint(equalTo: collectionNameLabel.topAnchor)
//            ])
    }
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "text-plus-icon"), for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .green
        button.isEnabled = false
        return button
    }()
    
    private func setupAddButton() {
        addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        addButton.snp.makeConstraints { (make) in
            make.center.equalTo(snp.center)
            make.width.height.equalTo(80)
        }
        
        
//        NSLayoutConstraint.activate([
//            addButton.centerXAnchor.constraint(equalTo: venueImageView.centerXAnchor),
//            addButton.centerYAnchor.constraint(equalTo: venueImageView.centerYAnchor),
//            addButton.heightAnchor.constraint(equalToConstant: 80),
//            addButton.widthAnchor.constraint(equalToConstant: 80)
//            ])
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
        setupCollectionNameLabel()
        setupVenueImageView()
        setupAddButton()
    }
    
}
