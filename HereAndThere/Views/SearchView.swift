//  SearchView.swift
//  HereAndThere
//  Created by C4Q on 1/16/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.

import UIKit
import MapKit

//Custom View for overall Layout of SearchViewController
class SearchView: UIView {
    
    var collectionViewBottomConstraint: NSLayoutConstraint!
    
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
        cv.backgroundColor = .blue
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
		addSearchMap()
        addCitySearchBar()
        setupContainerView()
		addCollectionView()
        addVenueSearchBar()
	}
    
    lazy var containerView: UIView = {
        let view = UIView()
        let blurEffect = UIBlurEffect(style: .extraLight)// .light, .dark, .prominent, .regular, .extraLight
        let visualEffect = UIVisualEffectView(frame: collectionView.frame)
        view.backgroundColor = .white // for testing
        
//        let gradient = CAGradientLayer()
//        visualEffect.effect = blurEffect
//        view.addSubview(visualEffect)
//        gradient.colors = [UIColor.black.cgColor, UIColor.blue.cgColor]
//        view.layer.addSublayer(gradient)
        return view
    }()

	// MARK: - Add elements & layout constraints to View
	private func addCitySearchBar(){
        addSubview(citySearchBar)
        citySearchBar.translatesAutoresizingMaskIntoConstraints = false
        citySearchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        citySearchBar.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        citySearchBar.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        citySearchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
	}
    
    private func setupContainerView() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.centerXAnchor.constraint(equalTo:  searchMap.centerXAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: searchMap.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: searchMap.trailingAnchor).isActive = true
        collectionViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: searchMap.bottomAnchor)
        collectionViewBottomConstraint.isActive = true
        containerView.heightAnchor.constraint(equalTo: searchMap.heightAnchor, multiplier: 0.25).isActive = true
    }
    
	private func addSearchMap(){
		addSubview(searchMap)
		searchMap.translatesAutoresizingMaskIntoConstraints = false
		searchMap.topAnchor.constraint(equalTo: topAnchor).isActive = true
		searchMap.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
		searchMap.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
		searchMap.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
	}
	private func addCollectionView(){
		addSubview(collectionView)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.centerXAnchor.constraint(equalTo:  containerView.centerXAnchor).isActive = true
		collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
		collectionView.heightAnchor.constraint(equalTo: searchMap.heightAnchor, multiplier: 0.23).isActive = true
	}
    private func addVenueSearchBar() {
        addSubview(venueSearchBar)
    }
}

