//  CollectionsViewController.swift
//  HereAndThere
//  Created by C4Q on 1/16/18.
//  Copyright © 2018 HereAndThere. All rights reserved.

import UIKit
import MaterialComponents.MDCCollectionViewController
import MaterialComponents

class CollectionsViewController: MDCCollectionViewController {
    
    let appBar = MDCAppBar()
    
    let cellSpacing: CGFloat = 9
    
    let colors = ["red", "blue", "green", "black", "yellow", "purple"]
    
    var collections = [String : [SavedVenue]]() {
        didSet {
            sortedKeys = collections.keys.sorted()
        }
    }
    
    var sortedKeys = [String]() {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView?.register(MDCCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView?.showsVerticalScrollIndicator = false
        
        configureNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        collections = DataPersistenceHelper.manager.getCollections()
    }
    
    // Configure nav bar
    func configureNavBar() {
        navigationItem.title = "My Collections"
        configureAddButton()
        configureBackButton()
    }
    
    // Add button
    func configureAddButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.setRightBarButton(addButton, animated: false)
    }
    
    @objc func addButtonTapped() {
        configureCreateNavBar()
    }
    
    // Back button
    func configureBackButton() {
        let backButton = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(backButtonTapped))
        navigationItem.backBarButtonItem = backButton
        navigationItem.hidesBackButton = false
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // Configure nav bar when add button is tapped
    func configureCreateNavBar() {
        navigationItem.title = "Add to or create collection."
        configureCreateButton()
        configureCancelButton()
    }
    
    // Create button
    func configureCreateButton() {
        let createButton = UIBarButtonItem(title: "Create", style: .done, target: self, action: #selector(createButtonTapped))
        navigationItem.rightBarButtonItem = createButton
    }
    
    @objc func createButtonTapped() {
        // TODO: - Save collection
        configureNavBar()
    }
    
    // Cancel button
    func configureCancelButton() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = cancelButton

<<<<<<< HEAD
	//MARK: View Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.9, alpha: 1.0)
	}
=======
    }
    
    @objc func cancelButtonTapped() {
        navigationItem.leftBarButtonItem = nil
        configureNavBar()
    }
    
}





extension CollectionsViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sortedKeys.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionMDCCollectionViewCell
        
        let collection = collections[sortedKeys[indexPath.row]]
        if (collection?.isEmpty)! {
            cell.collectionImageView.image = #imageLiteral(resourceName: "placeholder-image")
        } else {
            
            let venue = collection![0]
            
            if let image = DataPersistenceHelper.manager.getImage(with: venue.venueID) {
                cell.collectionImageView.image = image
            } else {
                cell.collectionImageView.image = #imageLiteral(resourceName: "placeholder-image")
            }
        }
        cell.collectionNameLabel.text = sortedKeys[indexPath.row]
>>>>>>> abdc9832faae546aae1008b6a4e02d57f54a6e4d

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numCells: CGFloat = 2
        let numSpaces: CGFloat = numCells + 1
        let screenWidth = UIScreen.main.bounds.width
        return CGSize(width: (screenWidth - (cellSpacing * numSpaces)) / numCells, height: (screenWidth - (cellSpacing * numSpaces)) / numCells)
    }
    //Layout - Inset for section
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    //Layout - line spacing
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    //Layout - inter item spacing
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    
}

