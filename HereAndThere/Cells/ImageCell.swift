//
//  ImageCell.swift
//  HereAndThere
//
//  Created by Ashlee Krammer on 1/24/18.
//  Copyright © 2018 HereAndThere. All rights reserved.
//

import UIKit
import SnapKit

class ImageCell: UITableViewCell {
    
    lazy var imageV: UIImageView = {
        let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFill
        imageV.clipsToBounds = true
        return imageV
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    
    func setUpView() {
        setUpImage()
    }
    
    func setUpImage() {
        addSubview(imageV)
        
        imageV.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.left.equalTo(safeAreaLayoutGuide).offset(5)
            make.right.equalTo(safeAreaLayoutGuide).offset(-5)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-20)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    
}
