//
//  ResultsView.swift
//  HereAndThere
//
//  Created by C4Q on 1/23/18.
//  Copyright © 2018 HereAndThere. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ResultsListView: UIView {
    
    //set up my objects
    lazy var tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    //MUST HAVE THE REQUIRED INIT IN EVERY VIEW!
    //Its used when its story board
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    //MUST ALWAYS HAVE THIS FUNC TOO!This function runs at the start of the view when it being initialized. Basically like view did load but for views
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setViews()
        backgroundColor = .yellow
        
    }
    
    func setViews(){
        //add all the views I'm setting up
        setTableView()
    }
    
    func setTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints {(make) in
            make.edges.equalTo(self)
        }
    }
}
