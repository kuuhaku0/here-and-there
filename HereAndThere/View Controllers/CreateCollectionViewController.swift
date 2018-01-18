//  CreateCollectionViewController.swift
//  HereAndThere
//  Created by Winston Marag on 1/17/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.


import UIKit

class CreateCollectionViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		createNavigationBar()

	}

	//Custom Methods
	func createNavigationBar() {
		self.navigationItem.title = "Add to or Create Collection"

		//create right bar button item for toggling between list and map
		let createBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(createCollection))
		navigationItem.rightBarButtonItem = createBarItem

		//create left bar button item for toggling between list and map
		let cancelBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "cancel2"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelCollection))
		navigationItem.leftBarButtonItem = cancelBarItem
	}

	@objc func createCollection() {


	}
	@objc func cancelCollection() {


	}



    


}
