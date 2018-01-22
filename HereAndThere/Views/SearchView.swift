//  SearchView.swift
//  HereAndThere
//  Created by C4Q on 1/16/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.

import UIKit
import MapKit

//Custom View for overall Layout of SearchViewController
class SearchView: UIView {

	// MARK: - Create elements in View
	lazy var venueSearchBar: UISearchBar = {
		let sb = UISearchBar()
		sb.showsCancelButton = false
		sb.placeholder = "Search for Venue"
		sb.barTintColor = .white
		sb.tag = 0
		return sb
	}()
	lazy var citySearchBar: UISearchBar = {
		let sb = UISearchBar()
		sb.showsCancelButton = true
		sb.placeholder = "New York, NY"
		sb.barTintColor = .white
//		sb.isSearchResultsButtonSelected = true
//		sb.isTranslucent = true
//		sb.searchBarStyle = UISearchBarStyle.minimal
		sb.tag = 1
		return sb
	}()
	lazy var searchMap: MKMapView = {
		let smap = MKMapView()
		smap.mapType = MKMapType.standard
		smap.isZoomEnabled = true
		smap.isScrollEnabled = true
		smap.isPitchEnabled = true
//		smap.isRotateEnabled = true
		smap.showsUserLocation = true
		smap.showsScale = true
		return smap
	}()
	lazy var userTrackingButton: MKUserTrackingButton = {
		let trackingButton = MKUserTrackingButton()
		trackingButton.backgroundColor = UIColor.clear
		return trackingButton
	}()
	lazy var collectionView: UICollectionView = {
		let cvLayout = UICollectionViewFlowLayout()
		cvLayout.scrollDirection = .horizontal
		let cv = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: cvLayout)
		cv.register(SearchCVCell.self, forCellWithReuseIdentifier: "SearchCVCell")
		cv.backgroundColor = UIColor.clear
		return cv
	}()


	// MARK: - Setup elements in View
	override init(frame: CGRect){
		super.init(frame: UIScreen.main.bounds)
		setupViews()
	}
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	override func layoutSubviews() {
		super.layoutSubviews()
	}
	private func setupViews() {
		addCitySearchBar()
		addSearchMap()
		addUserTrackingButton()
		userTrackingButton.mapView = searchMap //Configure the MKUserTrackingButton in your setupViews code
		addCollectionView()
	}


	// MARK: - Add elements & layout constraints to View
	private func addCitySearchBar(){
		addSubview(citySearchBar)
		citySearchBar.translatesAutoresizingMaskIntoConstraints = false
		citySearchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
		citySearchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
		citySearchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
	}
	private func addSearchMap(){
		addSubview(searchMap)
		searchMap.translatesAutoresizingMaskIntoConstraints = false
		searchMap.topAnchor.constraint(equalTo: citySearchBar.bottomAnchor).isActive = true
		searchMap.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
		searchMap.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
		searchMap.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
	}
	private func addUserTrackingButton(){
		addSubview(userTrackingButton)
		userTrackingButton.translatesAutoresizingMaskIntoConstraints = false
		userTrackingButton.topAnchor.constraint(equalTo: searchMap.topAnchor, constant: 45).isActive = true
		userTrackingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2).isActive = true
	}
	private func addCollectionView(){
		addSubview(collectionView)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.centerXAnchor.constraint(equalTo:  searchMap.centerXAnchor).isActive = true
		collectionView.leadingAnchor.constraint(equalTo: searchMap.leadingAnchor).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: searchMap.trailingAnchor).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: searchMap.bottomAnchor).isActive = true
		collectionView.heightAnchor.constraint(equalTo: searchMap.heightAnchor, multiplier: 0.2).isActive = true
	}
}

