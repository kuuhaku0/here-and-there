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

extension CollectionDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCell", for: indexPath) as! CollectionVenuesTableViewCell
        //TODO Configure Cell
        return cell
    }
    
}

extension CollectionDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
