//
//  CreateTipView.swift
//  HereAndThere
//
//  Created by Reiaz Gafar on 1/22/18.
//  Copyright © 2018 HereAndThere. All rights reserved.
//

import UIKit

class CreateTipView: UIView {
    
    lazy var newCollectionTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    lazy var tipLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var tipTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: safeAreaLayoutGuide.layoutFrame, collectionViewLayout: layout)
        collectionView.register(AddTipCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    
    
    
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
    }
    
}

