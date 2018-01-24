//
//  CreateCollectionView.swift
//  HereAndThere
//
//  Created by Reiaz Gafar on 1/24/18.
//  Copyright © 2018 HereAndThere. All rights reserved.
//

import UIKit
import SnapKit

class CreateCollectionView: UIView {

    lazy var collectionNameTextField: UITextField = {
        let textField = UITextField()
        return textField
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
