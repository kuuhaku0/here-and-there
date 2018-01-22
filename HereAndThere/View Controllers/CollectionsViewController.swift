//  CollectionsViewController.swift
//  HereAndThere
//  Created by C4Q on 1/16/18.
//  Copyright © 2018 HereAndThere. All rights reserved.

import UIKit
//import MaterialComponents.MDCCollectionViewController
//import MaterialComponents

class CollectionsViewController: UIViewController {


}


//class CollectionsViewController: MDCCollectionViewController {
//
////    let appBar = MDCAppBar()
//
//    let cellSpacing: CGFloat = 9
//
//    let colors = ["red", "blue", "green", "black", "yellow", "purple"]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        collectionView?.register(MDCCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
//        collectionView?.showsVerticalScrollIndicator = false
//    }
//}

//extension CollectionsViewController {
//
//    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let numCells: CGFloat = 2
//        let numSpaces: CGFloat = numCells + 1
//        let screenWidth = UIScreen.main.bounds.width
//        return CGSize(width: (screenWidth - (cellSpacing * numSpaces)) / numCells, height: (screenWidth - (cellSpacing * numSpaces)) / numCells)
//    }
//    //Layout - Inset for section
//    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
//    }
//    //Layout - line spacing
//    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return cellSpacing
//    }
//    //Layout - inter item spacing
//    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return cellSpacing
//    }
//}

//extension CollectionsViewController {
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MDCCollectionViewCell
////        let color = colors[indexPath.row]
//        cell.backgroundColor = .blue
//
//        return cell
//    }
//}

