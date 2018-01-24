////
////  SearchViewCollectionViewController.swift
////  HereAndThere
////
////  Created by C4Q on 1/20/18.
////  Copyright © 2018 HereAndThere. All rights reserved.
////
//
//import UIKit
//
//private let reuseIdentifier = "Cell"
//
//class SearchViewCollectionViewController: UICollectionViewController {
//    
//    let cellSpacing: CGFloat = 10
//    
//    override init(collectionViewLayout layout: UICollectionViewLayout) {
//        super.init(collectionViewLayout: layout)
//    }
//    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//
//    }
//}
//
//
//func numberOfSections(in collectionView: UICollectionView) -> Int {
//    return 1
//}
////# of items in section
//func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return 10
//}
////setup for cell
//func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCVCell", for: indexPath) as! SearchCVCell
//    
//    //altering Cell shape & border
//    customCell.layer.cornerRadius = 5.0
//    customCell.layer.borderColor = UIColor.blue.cgColor
//    customCell.layer.borderWidth = 1.0
//    
//    //setup attributes
//    customCell.backgroundColor = .white //cell color
//    // property
//    //        let venue = venues[indexPath.row]
//    
//    //get image
//    customCell.imageView.image = nil
//    
//    //Get Photo Data from venue ID
//    //        PhotoAPIClient.manager.getVenuePhotos(venueID: venue.id) {self.venuesPhotos = $0}
//    
//    //        let imageStr = "\(prefix)\(size)\(suffix)"
//    
//    //call ImageHelper
//    //            ImageHelper.manager.getImage(from: "https://igx.4sqi.net/img/general/300x500/5163668_xXFcZo7sU8aa1ZMhiQ2kIP7NllD48m7qsSwr1mJnFj4.jpg",
//    //                                                                     completionHandler: { customCell.imageView.image = $0; customCell.setNeedsLayout();},
//    //                                                                     errorHandler: {print($0)})
//    
//    return customCell
//}
//
//
////MARK: CollectionView - Delegate Flow Layout
//
//extension SearchViewCollectionViewController : UICollectionViewDelegateFlowLayout {
//    //Layout - Size for item
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let numCells: CGFloat = 4
//        let numSpaces: CGFloat = numCells + 1
//        let screenWidth = UIScreen.main.bounds.width
//        return CGSize(width: (screenWidth - (cellSpacing * numSpaces)) / numCells, height: collectionView.bounds.height - (cellSpacing * 2))
//    }
//    //Layout - Inset for section
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
//    //Layout - line spacing
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return cellSpacing + 5
//    }
//    //Layout - inter item spacing
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return cellSpacing
//    }
//}

