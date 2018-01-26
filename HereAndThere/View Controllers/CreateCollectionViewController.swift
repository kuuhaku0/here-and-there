//
//  CreateCollectionViewController.swift
//  HereAndThere
//
//  Created by Reiaz Gafar on 1/24/18.
//  Copyright © 2018 HereAndThere. All rights reserved.
//

import UIKit

class CreateCollectionViewController: UIViewController {

    let createCollectionView = CreateCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(createCollectionView)
        configureCreateNavBar()
    }
    
    // Configure nav bar when add button is tapped
    func configureCreateNavBar() {
        navigationItem.title = "Add a Collection"
        configureCreateButton()
        configureCancelButton()
    }
    
    // Create button
    func configureCreateButton() {
        let createButton = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(createButtonTapped))
        navigationItem.rightBarButtonItem = createButton
    }
    
    @objc func createButtonTapped() {
        print("CREATE TAPPED")
        
        guard let text = createCollectionView.collectionNameTextField.text else { return }
        
        if DataPersistenceHelper.manager.addCollection(name: text.capitalized) {
            alertController(title: "Success", message: "You have saved a new collection.")
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    // Cancel button
    func configureCancelButton() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = cancelButton
        
    }
    
    @objc func cancelButtonTapped() {
        navigationItem.leftBarButtonItem = nil
        navigationController?.popViewController(animated: true)
    }
    
    

}

// MARK: - Helper Functions
extension CreateCollectionViewController {
    func alertController(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(alert, animated: true, completion: nil)
        
    }
}
