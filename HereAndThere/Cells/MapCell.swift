//
//  MapCell.swift
//  HereAndThere
//
//  Created by Ashlee Krammer on 1/24/18.
//  Copyright © 2018 HereAndThere. All rights reserved.
//

import UIKit
import MapKit
import SnapKit

class MapCell: UITableViewCell {

    lazy var mapV: MKMapView = {
        let mv = MKMapView()
        mv.clipsToBounds = true
        return mv
    }()
    
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
        addSubview(mapV)
        mapV.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(safeAreaLayoutGuide)
            make.left.equalTo(safeAreaLayoutGuide).offset(5)
            make.right.equalTo(safeAreaLayoutGuide).offset(-5)
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.centerX.equalTo(self.snp.centerX)
    }

}
}
