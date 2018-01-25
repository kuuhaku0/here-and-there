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


    //picture
    lazy var imageView: UIImageView = {
        let imageV = UIImageView() //default image
        imageV.image = #imageLiteral(resourceName: "placeholder-image")
        imageV.contentMode = .scaleAspectFill
        imageV.backgroundColor = .white
        return imageV
    }()
    
    //type of place label
    lazy var placeLabel: UILabel = {
       let label = UILabel()
        label.text = "Place Label"
        return label
    }()
    
    //notes label
    lazy var notesLabel: UILabel = {
        let label = UILabel()
        label.text = "Notes Label"
        return label
    }()
    

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setUpView() {
        setUpImage()
        setUpPlaceLabel()
        setUpNotesLabel()
    }
    
    func setUpImage() {
        addSubview(imageView)

        imageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.left.equalTo(safeAreaLayoutGuide).offset(10)
            make.right.equalTo(safeAreaLayoutGuide).offset(-10)
            make.height.equalTo(self).multipliedBy(0.65)
            make.centerX.equalTo(self.snp.centerX)


        }
    }
}
