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
    
    var collectionName: String!
    var collectionVenues: [SavedVenue]!
    
    
    convenience init(collectionName: String, venues: [SavedVenue]) {
        self.init(nibName: nil, bundle: nil)
        self.collectionName = collectionName
        self.collectionVenues = venues
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionDetailView)
        collectionDetailView.tableView.dataSource = self
        collectionDetailView.tableView.delegate = self
    }

}

extension CollectionDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionVenues.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VenueCell", for: indexPath) as! CollectionVenuesTableViewCell
        
        let venue = collectionVenues[indexPath.row]
        cell.textLabel?.text = venue.venue.name
        cell.imageView?.image = DataPersistenceHelper.manager.getImage(with: venue.venueID)
        return cell
    }
    
}

extension CollectionDetailViewController: UITableViewDelegate {
    // Did select row
    // Transitions to detail vc
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CollectionVenuesTableViewCell
        let venue = collectionVenues[indexPath.row]
        let detailVC = DetailViewController(venue: venue.venue, image: cell.imageView?.image ?? #imageLiteral(resourceName: "placeholder-image"), tip: venue.tip)
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
