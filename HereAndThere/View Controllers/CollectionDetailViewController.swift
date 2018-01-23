//
//  CollectionDetailViewController.swift
//  HereAndThere
//
//  Created by Reiaz Gafar on 1/22/18.
//  Copyright © 2018 HereAndThere. All rights reserved.
//

import UIKit

class CollectionDetailViewController: UIViewController {

    let collectionDetailView = CollectionDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionDetailView)
        collectionDetailView.tableView.dataSource = self
        collectionDetailView.tableView.delegate = self
        
        
        // TODO FILE MANAGER COLLECTIONS
        
    }

}

extension CollectionDetailView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
}

extension CollectionDetailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
