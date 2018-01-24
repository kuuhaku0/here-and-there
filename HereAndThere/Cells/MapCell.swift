//
//  MapCell.swift
//  HereAndThere
//
//  Created by Ashlee Krammer on 1/24/18.
//  Copyright © 2018 HereAndThere. All rights reserved.
//

import UIKit

class MapCell: UITableViewCell {

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setUpView() {
        setUpMap()
    }
    
    func setUpMap() {
        
    }

}
