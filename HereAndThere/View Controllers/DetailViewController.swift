//  DetailViewController.swift
//  HereAndThere
//  Created by C4Q on 1/16/18.
//  Copyright © 2018 HereAndThere. All rights reserved.

import UIKit

class DetailViewController: UIViewController {

    var detailedView = DetailedView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailedView)

    }

    private func configureNavBar() {
        navigationItem.title = "YAY Large Titles"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}


