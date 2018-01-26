//
//  DetailedView.swift
//  HereAndThere
//
//  Created by Ashlee Krammer on 1/22/18.
//  Copyright © 2018 HereAndThere. All rights reserved.
//

import UIKit
import SnapKit

class DetailedView: UIView {
    
    lazy var tableView: UITableView = {
        let tbV = UITableView()
        return tbV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setUpView() {
        setUpTableView()
    }
    
    func setUpTableView() {
        addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
    }
}
