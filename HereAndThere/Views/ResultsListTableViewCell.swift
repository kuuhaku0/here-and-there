//
//  ResultsTableViewCell.swift
//  HereAndThere
//
//  Created by C4Q on 1/23/18.
//  Copyright © 2018 HereAndThere. All rights reserved.
//

import UIKit
//TODO: after MVP is completed
class ResultsListTableViewCell: UITableViewCell {
    
    lazy var indicator: UIActivityIndicatorView = {
        let ind = UIActivityIndicatorView()
        ind.activityIndicatorViewStyle = .gray
        ind.color = UIColor(red: 210/255, green: 215/255, blue: 219/255, alpha: 1)
        return ind
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "ResultsTableViewCell")
        commonInit()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        setupViews()
    }
    
    private func setupViews() {
        addIndicatorView()
    }
    
    //create objects
    private func addIndicatorView() {
        addSubview(indicator)
        indicator.snp.makeConstraints {
            $0.centerX.equalTo(snp.centerX)
            $0.centerY.equalTo(snp.centerY)
        }
    }
    
    
    //initialize views
//   init(frame: CGRect) {
//        super.init(frame: frame)
//        backgroundColor = .green
//        setCell()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    //set constraints
//    func setCell(){
//        addSubview(cellLabel)
//        //TODO: use snapkit to set
//    }
}
