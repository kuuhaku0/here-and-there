//
//  CollectionsView.swift
//  HereAndThere
//
//  Created by C4Q on 1/19/18.
//  Copyright © 2018 HereAndThere. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialCollections

class CollectionsView: UIView {

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
    
    lazy var collectionView: UICollectionView = {
        let cvLayout = MDCCollectionViewFlowLayout()
        cvLayout.scrollDirection = .vertical
        let cv = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: cvLayout)
        cv.register(SearchCVCell.self, forCellWithReuseIdentifier: "SearchCVCell")
        cv.backgroundColor = UIColor.lightGray
        return cv
    }()
    
}
