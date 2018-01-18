//  CollectionsViewController.swift
//  HereAndThere
//  Created by C4Q on 1/16/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.

import UIKit

class CollectionsViewController: UIViewController {

	// MARK: - Create CollectionView
	let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		let cv = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
		cv.backgroundColor = UIColor.clear
		cv.register(CollectionsCVCell.self, forCellWithReuseIdentifier: "CollectionCVCell")
		return cv
	}()


	//MARK: Properties
	let cellSpacing: CGFloat = 5.0


	//MARK: View Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(collectionView)  //must add custom View here
		collectionView.delegate = self
		collectionView.dataSource = self
		self.view.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
		configureNavBar()
	}

	private func configureNavBar(){
		navigationItem.title = "Collections"
		//create right bar button item for toggling between list and map
		let addBarItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCollection))
		navigationItem.rightBarButtonItem = addBarItem
	}

	@objc func addCollection() {
		
	}
}


//MARK: CollectionView - Datasource
extension CollectionsViewController: UICollectionViewDataSource {
	//Number of items in Section
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 21 //venues.count
	}
	//setup for each cell
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCVCell", for: indexPath) as! CollectionsCVCell //using custom cell

		//altering Cell shape & border & color
		cell.layer.cornerRadius = 5.0
		cell.layer.borderColor = UIColor.blue.cgColor
		cell.layer.borderWidth = 1.0
		cell.backgroundColor =  UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)

		//property
		//	let venue = venues[indexPath.item]

		//set image
		cell.imageView.image = nil
		cell.imageView.image = #imageLiteral(resourceName: "placeholder-image") //placeholder - get image from venue photo

		return cell
	}
}


//MARK: CollectionView - Delegate Flow Layout
extension CollectionsViewController: UICollectionViewDelegateFlowLayout {
	//Layout - Size for item
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let numCells: CGFloat = 2
		let numSpaces: CGFloat = numCells + 1
		let screenWidth = UIScreen.main.bounds.width
		let screenHeight = UIScreen.main.bounds.height
		return CGSize(width: (screenWidth - (cellSpacing * numSpaces)) / numCells, height: screenHeight * 0.25)
	}
	//Layout - Inset for section
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: 0, right: cellSpacing)
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

//MARK: CollectionView Delegate
extension CollectionsViewController : UICollectionViewDelegate {
	//action for selected item
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		//	let venue = venues[indexPath.row]
		//	let detailVC = DetailViewController(venue: venues[indexPath.row] )
			let detailVC = DetailViewController()
			self.navigationController?.pushViewController(detailVC, animated: true)
	}
}

