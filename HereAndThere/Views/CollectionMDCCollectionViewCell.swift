//
//  CollectionMDCCollectionViewCell.swift
//  HereAndThere
//
//  Created by Reiaz Gafar on 1/23/18.
//  Copyright © 2018 HereAndThere. All rights reserved.
//

import UIKit
import SnapKit
import MaterialComponents

class CollectionMDCCollectionViewCell: MDCCollectionViewCell {
    
    lazy var collectionNameLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    private func setupCollectionNameLabel() {
        addSubview(collectionNameLabel)
        collectionNameLabel.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(self.snp.bottom)
            maker.leading.equalTo(self.snp.leading)
            maker.trailing.equalTo(self.snp.trailing)
            
            
        }
    }
    
    
    lazy var collectionImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private func setupImageView() {
        addSubview(collectionImageView)
        collectionImageView.snp.makeConstraints({ (maker) in
            maker.bottom.equalTo(collectionNameLabel.snp.top).offset(4)
            maker.leading.equalTo(self.snp.leading)
            maker.trailing.equalTo(self.snp.trailing)
            maker.top.equalTo(self.snp.top)
        })
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
        setupImageView()
    }
    

    
    
    
}
