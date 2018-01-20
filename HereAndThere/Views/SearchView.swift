//  SearchView.swift
//  HereAndThere
//  Created by C4Q on 1/16/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.

import UIKit
import MapKit
import MaterialComponents.MaterialCollections
//Custom View for overall Layout of SearchViewController
class SearchView: UIView {

	
	// MARK: - Create elements in View
	lazy var venueSearchBar: UISearchBar = {
		let sb = UISearchBar()
		sb.showsCancelButton = false
		sb.barTintColor = .white
		sb.placeholder = "Search for Venue"
		sb.tag = 0
		return sb
	}()
	lazy var citySearchBar: UISearchBar = {
		let csb = UISearchBar()
        csb.barStyle = .default
		csb.showsCancelButton = false
        csb.backgroundColor = .white
		csb.placeholder = "New York, NY"
		csb.barTintColor = .white
		csb.tag = 1
		csb.barTintColor = .white
		return csb
	}()
    
	lazy var searchMap: MKMapView = {
		let smap = MKMapView()
		smap.mapType = MKMapType.standard
		smap.isZoomEnabled = true
		smap.isScrollEnabled = true
		smap.isPitchEnabled = true
		smap.isRotateEnabled = true
		smap.showsUserLocation = true
		return smap
	}()
    
	lazy var collectionView: UICollectionView = {
		let cvLayout = UICollectionViewFlowLayout()
		cvLayout.scrollDirection = .horizontal
		let cv = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: cvLayout)
		cv.register(SearchCVCell.self, forCellWithReuseIdentifier: "SearchCVCell")
		cv.backgroundColor = UIColor.lightGray
		return cv
	}()
  
	// MARK: - Setup elements in View
	override init(frame: CGRect){
		super.init(frame: UIScreen.main.bounds)
		commonInit()
	}
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}
	private func commonInit() {
		setupViews()
	}
	override func layoutSubviews() {
		super.layoutSubviews()
	}
	func setupViews() {
		addCitySearchBar()
		addSearchMap()
		addCollectionView()
        addVenueSearchBar()
	}


	// MARK: - Add elements & layout constraints to View
	private func addCitySearchBar(){
        addSubview(citySearchBar)
        citySearchBar.translatesAutoresizingMaskIntoConstraints = false
        citySearchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        citySearchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        citySearchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        citySearchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
	}
	private func addSearchMap(){
		addSubview(searchMap)
		searchMap.translatesAutoresizingMaskIntoConstraints = false
		searchMap.topAnchor.constraint(equalTo: citySearchBar.bottomAnchor).isActive = true
		searchMap.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
		searchMap.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
		searchMap.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
	}
	private func addCollectionView(){
		addSubview(collectionView)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.centerXAnchor.constraint(equalTo:  searchMap.centerXAnchor).isActive = true
		collectionView.leadingAnchor.constraint(equalTo: searchMap.leadingAnchor).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: searchMap.trailingAnchor).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: searchMap.bottomAnchor, constant: -20).isActive = true
		collectionView.heightAnchor.constraint(equalTo: searchMap.heightAnchor, multiplier: 0.2).isActive = true
	}
    private func addVenueSearchBar() {
        addSubview(venueSearchBar)
    }
}

