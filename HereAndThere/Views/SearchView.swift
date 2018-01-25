//  SearchView.swift
//  HereAndThere
//  Created by Winston Maragh on 1/16/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.

import UIKit
import MapKit

//Custom View for overall Layout of SearchViewController
class SearchView: UIView {
    
    var collectionViewBottomConstraint: NSLayoutConstraint!


	// MARK: - Create elements in View
	lazy var optionsView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.showsHorizontalScrollIndicator = true
		scrollView.isScrollEnabled = true
		return scrollView
	}()

	lazy var venueSearchBar: UISearchBar = {
		let sb = UISearchBar()
		sb.showsCancelButton = false
		sb.placeholder = "Search for Venue"
		sb.barTintColor = UIColor(red: 55/255, green: 125/255, blue: 255/255, alpha: 1)
        sb.snapshotView(afterScreenUpdates: true)
		sb.tag = 0
		return sb
	}()
	lazy var nearSearchBar: UISearchBar = {
		let sb = UISearchBar()
		sb.showsCancelButton = false
		sb.placeholder = "New York, NY"
		sb.barTintColor = .white
        sb.tintColor = .white
        sb.layer.borderColor = UIColor.white.cgColor
            //UIColor(red: 55/255, green: 125/255, blue: 255/255, alpha: 1)
		//		sb.isSearchResultsButtonSelected = true
		//		sb.isTranslucent = true
		//		sb.searchBarStyle = UISearchBarStyle.minimal
		sb.setImage(UIImage(named: "near"), for: .search, state: .normal)
		sb.isHidden = true
		sb.tag = 1
        sb.showsCancelButton = false
		return sb
	}()


	lazy var stackSearchBars: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = UILayoutConstraintAxis.vertical
		stackView.distribution = UIStackViewDistribution.equalSpacing
		stackView.alignment = UIStackViewAlignment.center
		stackView.spacing = 0
		return stackView
	}()
    
    lazy var containerView: UIView = {
        let view = UIView()
        let blurEffect = UIBlurEffect(style: .extraLight)// .light, .dark, .prominent, .regular, .extraLight
        let visualEffect = UIVisualEffectView(frame: collectionView.frame)
        view.backgroundColor = .clear // for testing
        return view
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
		let scale = MKScaleView(mapView: smap)
		scale.scaleVisibility = .visible // always visible
//		view.addSubview(scale)
		return smap
	}()
	lazy var userTrackingButton: MKUserTrackingButton = {
		let trackingButton = MKUserTrackingButton()
		trackingButton.backgroundColor = UIColor.white
		return trackingButton
	}()
	lazy var collectionView: UICollectionView = {
		let cvLayout = UICollectionViewFlowLayout()
		cvLayout.scrollDirection = .horizontal
		let cv = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: cvLayout)
		cv.register(SearchCVCell.self, forCellWithReuseIdentifier: "SearchCVCell")
		cv.backgroundColor = .clear
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
		addSearchMap()
		addUserTrackingButton()
		addNearSearchBar()
		userTrackingButton.mapView = searchMap //Configure the MKUserTrackingButton in your setupViews code
        setupContainerView()
		addCollectionView()
	}


	// MARK: - Add elements & layout constraints to View

	private func addCitySearchBar(){
		addSubview(citySearchBar)
		citySearchBar.translatesAutoresizingMaskIntoConstraints = false
        citySearchBar.layer.borderColor = UIColor.clear.cgColor
		citySearchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        citySearchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        citySearchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        citySearchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
  }
 	private func addNearSearchBar(){
 		addSubview(nearSearchBar)
 		nearSearchBar.translatesAutoresizingMaskIntoConstraints = false
 		nearSearchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
 		nearSearchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
 		nearSearchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
 	}
  
	private func addSearchMap(){
		addSubview(searchMap)
		searchMap.translatesAutoresizingMaskIntoConstraints = false
		searchMap.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
		searchMap.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
		searchMap.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
		searchMap.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
	}
	private func addUserTrackingButton(){
		addSubview(userTrackingButton)
		userTrackingButton.translatesAutoresizingMaskIntoConstraints = false
		userTrackingButton.topAnchor.constraint(equalTo: searchMap.topAnchor, constant: 5).isActive = true
		userTrackingButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -1).isActive = true
	}
	private func addCollectionView(){
		addSubview(collectionView)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.centerXAnchor.constraint(equalTo:  searchMap.centerXAnchor).isActive = true
		collectionView.leadingAnchor.constraint(equalTo: searchMap.leadingAnchor).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: searchMap.trailingAnchor).isActive = true

		collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
		collectionView.heightAnchor.constraint(equalTo: searchMap.heightAnchor, multiplier: 0.25).isActive = true

// 		collectionView.bottomAnchor.constraint(equalTo: searchMap.bottomAnchor, constant: -5).isActive = true
// 		collectionView.heightAnchor.constraint(equalTo: searchMap.heightAnchor, multiplier: 0.15).isActive = true

	}
    private func setupContainerView() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.centerXAnchor.constraint(equalTo:  searchMap.centerXAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: searchMap.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: searchMap.trailingAnchor).isActive = true
        collectionViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        collectionViewBottomConstraint.isActive = true
        containerView.heightAnchor.constraint(equalTo: searchMap.heightAnchor, multiplier: 0.25).isActive = true
    }

}
