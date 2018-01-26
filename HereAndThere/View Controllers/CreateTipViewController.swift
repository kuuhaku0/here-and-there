//
//  CreateCollectionViewController.swift
//  HereAndThere
//
//  Created by Reiaz Gafar on 1/22/18.
//  Copyright © 2018 HereAndThere. All rights reserved.
//

import UIKit

class CreateTipViewController: UIViewController {
    
    let createTipView = CreateTipView()
    let cellSpacing: CGFloat = 9
    
    var venue: Venue!
    var image: UIImage!
    
    var collections = [String : [SavedVenue]]() {
        didSet {
            sortedKeys = collections.keys.sorted()
        }
    }
    
    var sortedKeys = [String]() {
        didSet {
            createTipView.collectionView.reloadData()
        }
    }
    
    convenience init(venue: Venue, image: UIImage) {
        self.init(nibName: nil, bundle: nil)
        self.venue = venue
        self.image = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(createTipView)
        configureNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collections = DataPersistenceHelper.manager.getCollections()
    }
    
    // Function to configure the nav bar
    func configureNavBar() {
        navigationItem.title = "Add to or create collection."
        setupCreateButton()
        setupCancelButton()
        createTipView.collectionView.dataSource = self
        createTipView.collectionView.delegate = self
    }
    
    // Function to setup a list button on the nav bar
    func setupCreateButton() {
        let createBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(createButtonTapped))
        navigationItem.rightBarButtonItem = createBarButtonItem
    }
    
    // Function that's called when the list button is tapped
    @objc func createButtonTapped() {
        
        guard let text = createTipView.newCollectionTextField.text else { return }
        guard text != "" else { alertController(title: "Error", message: "Please enter a name for your collection.");  return }
        
        if DataPersistenceHelper.manager.addVenueToCollection(collectionName: text, venue: venue, tip: createTipView.tipTextField.text, venueID: venue.id, image: image) {
            alertControllerAndPop(title: "Success", message: "You have saved a venue to a new collection.")
            //navigationController?.popViewController(animated: true)
        }
    }
    
    // Function to setup a search button on the nav bar
    func setupCancelButton() {
        let cancelBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = cancelBarButtonItem
    }
    
    // Function that's called when the search button is tapped
    @objc func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    
    

}

// MARK: - Helper Functions
extension CreateTipViewController {
    func alertControllerAndPop(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel){ (done) in self.navigationController?.popViewController(animated: true) })
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func alertController(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(alert, animated: true, completion: nil)
        
    }
}

extension CreateTipViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sortedKeys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! AddTipCollectionViewCell
        cell.layer.cornerRadius = 15
        let collection = collections[sortedKeys[indexPath.row]]
        if (collection?.isEmpty)! {
            cell.venueImageView.image = #imageLiteral(resourceName: "placeholder-image")
            //cell.collectionImageView.image = #imageLiteral(resourceName: "placeholder-image")
        } else {
            
            let venue = collection![0]
            
            if let image = DataPersistenceHelper.manager.getImage(with: venue.venueID) {
                cell.venueImageView.image = image
                //cell.collectionImageView.image = image
            }
        }
        
        cell.collectionNameLabel.text = sortedKeys[indexPath.row]
        
        return cell
    }

}

extension CreateTipViewController: UICollectionViewDelegate {
    // Did select cell
    // Segues to collection detail vc
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if DataPersistenceHelper.manager.addVenueToCollection(collectionName: sortedKeys[indexPath.row], venue: venue, tip: createTipView.tipTextField.text, venueID: venue.id, image: image) {
            alertControllerAndPop(title: "Success", message: "You have saved a venue.")
            
        }
        
        // For segueing to the collection
        // let collectionDetailVC = CollectionDetailViewController(collectionName: sortedKeys[indexPath.row], venues: collections[sortedKeys[indexPath.row]]!)
        // navigationController?.pushViewController(collectionDetailVC, animated: true)
    }


    
}

extension CreateTipViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numCells: CGFloat = 2
        let numSpaces: CGFloat = numCells + 1
        let screenWidth = UIScreen.main.bounds.width
        return CGSize(width: (screenWidth - (cellSpacing * numSpaces)) / numCells, height: (screenWidth - (cellSpacing * numSpaces)) / numCells)
    }
    //Layout - Inset for section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    //Layout - line spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    //Layout - inter item spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
}

