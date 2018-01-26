//
//  CreateTipView.swift
//  HereAndThere
//
//  Created by Reiaz Gafar on 1/22/18.
//  Copyright © 2018 HereAndThere. All rights reserved.
//

import UIKit
import SnapKit

class CreateTipView: UIView {
    
    lazy var newCollectionTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.layer.borderWidth = 2
        textField.tintColor = .black
        textField.backgroundColor = .white
        textField.placeholder = "Enter a new collection title here."
        return textField
    }()
    
    private func setupNewCollectionTextField() {
        addSubview(newCollectionTextField)
        newCollectionTextField.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(35)
        }
    }
    
    lazy var tipLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter a tip!"
        return label
    }()
    
    private func setupTipLabel() {
        addSubview(tipLabel)
        tipLabel.snp.makeConstraints { (make) in
            make.top.equalTo(newCollectionTextField.snp.bottom).offset(8)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(25)
        }
    }
    
    lazy var tipTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.layer.borderWidth = 2
        textField.tintColor = .black
        textField.backgroundColor = .white
        textField.placeholder = "Write your tip here."
        return textField
    }()
    
    private func setupTipTextField() {
        addSubview(tipTextField)
        tipTextField.snp.makeConstraints { (make) in
            make.top.equalTo(tipLabel.snp.bottom)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(80)
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: safeAreaLayoutGuide.layoutFrame, collectionViewLayout: layout)
        collectionView.register(AddTipCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
        collectionView.backgroundColor = UIColor(red: 6/255, green: 101/255, blue: 143/255, alpha: 1)
        return collectionView
    }()
    
    private func setupCollectionView() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.50)
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
        setupNewCollectionTextField()
        setupTipLabel()
        setupTipTextField()
        setupNewCollectionTextField()
        setupCollectionView()
    }
    
}

