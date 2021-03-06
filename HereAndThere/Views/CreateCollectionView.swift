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
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.layer.borderWidth = 2
        textField.tintColor = .black
        textField.backgroundColor = .white
        textField.placeholder = "Enter a collection name."
        return textField
    }()
    
    private func setupCollectionNameTextField() {
        addSubview(collectionNameTextField)
        collectionNameTextField.snp.makeConstraints { (maker) in
            maker.top.equalTo(safeAreaLayoutGuide.snp.top).offset(-20)
            maker.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(8)
            maker.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-8)
            maker.height.equalTo(safeAreaLayoutGuide.snp.height).dividedBy(10)
        }
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
        setupCollectionNameTextField()
    }
    


}
