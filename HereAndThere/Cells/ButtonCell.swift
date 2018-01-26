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
        button.setImage(#imageLiteral(resourceName: "car"), for: .normal)
        button.setTitle("     Get Directions", for: .normal)
        button.titleLabel?.textAlignment = .center
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
            make.top.equalTo(snp.top)
            make.bottom.equalTo(snp.bottom)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.50)
        }
        
    }

}
