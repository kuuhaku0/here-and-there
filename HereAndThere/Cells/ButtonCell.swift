//
//  ButtonCell.swift
//  HereAndThere
//
//  Created by Ashlee Krammer on 1/24/18.
//  Copyright © 2018 HereAndThere. All rights reserved.
//

import UIKit

class ButtonCell: UITableViewCell {

    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Get Directions", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = .black
        button.backgroundColor = .green
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setUpView() {
        setUpButton()
    }
    
    func setUpButton() {
        addSubview(button)
        button.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(safeAreaLayoutGuide)
            make.left.equalTo(safeAreaLayoutGuide)
            make.right.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.centerX.equalTo(self.snp.centerX)
        }
        
    }

}
