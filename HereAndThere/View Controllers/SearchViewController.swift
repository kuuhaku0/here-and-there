//  SearchViewController.swift
//  HereAndThere
//  Created by Winston Maragh on 1/16/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.

import UIKit
import CoreLocation
import MapKit
//import SnapKit
import MaterialComponents.MaterialCollections
import MaterialComponents.MaterialCollectionLayoutAttributes

class SearchViewController: UIViewController {

	//create instance of custom View
	var searchView = SearchView()

	// MARK: Properties
	var locationManager: CLLocationManager! //instance of Location Manager
	var currentLocation: CLLocation!
	var latLong: String = ""
	var near: String = "" //New%20York,%20NY
	var venueSearchTerm = "" {
		didSet {
            loadVenues(search: venueSearchTerm, latLong: latLong, near: near)
        }
	}
    
	var venues: [Venue] = [] {
		didSet {
			DispatchQueue.main.async {
//                self.searchView.collectionView.reloadData()
				self.addVenueLocationsOnMap()
			}
		}
	}
    
	var venuesPhotos = [PhotosItem]() {
		didSet {
//            self.searchView.collectionView.reloadData()
		}
	}
    
	let cellSpacing: CGFloat = 1.0 //cellspacing Property for collectionView Flow Layout

	//MARK: View Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(searchView)  //add customView to access properties

		//Delegates and Datasource
		searchView.collectionView.delegate = self
		searchView.collectionView.dataSource = self
		searchView.venueSearchBar.delegate = self
		searchView.citySearchBar.delegate = self
		searchView.searchMap.delegate = self
        searchView.venueSearchBar.delegate = self
        
		//Setup
		setupUI()
		setupLocation()
		loadVenues(search: "chinese", latLong: latLong, near: near) //load default venues on startup
//      PhotoAPIClient.manager.getVenuePhotos(venueID: "525eeb3811d2c49bf03e23ec")
	}
    
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		setupLocation()
	}

	//Custom Methods
	func setupUI(){
		self.view.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.9, alpha: 1.0)
        tabBarController?.tabBar.backgroundColor = .white
        tabBarController?.tabBar.barTintColor = .white
        setupNavigationBar()
    }
    func setupLocation(){
        determineMyLocation()
        currentLocation = CLLocation(latitude: 40.743034, longitude: -73.941832)
        latLong = "\(currentLocation.coordinate.latitude),\(currentLocation.coordinate.longitude)"
    }
    func setupNavigationBar() {
//        navigationItem.title = "Search"
        navigationItem.titleView = searchView.venueSearchBar
    navigationItem.titleView?.backgroundColor = .white

		//right bar button for toggling between map & list
		let toggleBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(toggleListAndMap))
		navigationItem.rightBarButtonItem = toggleBarItem
	}
  
	@objc func toggleListAndMap() {
		self.navigationController?.pushViewController(ResultsViewController(), animated: true)
	}


	func checkUserLocationPermission(){
		switch CLLocationManager.authorizationStatus() {
			case .authorizedAlways, .authorizedWhenInUse:
				print(); print("Authorized"); print()
			case .denied:
				print(); print("Denied"); print()
                
				//opens phone Settings so user can authorize permission
				guard let validSettingsURL: URL = URL(string: UIApplicationOpenSettingsURLString) else {return}
				UIApplication.shared.open(validSettingsURL, options: [:], completionHandler: nil)
			case .notDetermined:
				print(); print("Not Determined"); print()
				locationManager.requestWhenInUseAuthorization()
			case .restricted:
				print(); print("Restricted"); print()
		}
	}

	//load the venues (API Call) in venues array
	func loadVenues(search: String, latLong: String, near: String) {
        SearchAPIClient.manager.getVenues(from: search, latLong: latLong, near: near) { self.venues = $0 }
    }
    
	func addVenueLocationsOnMap(){
		var venueAnnotations: [MKAnnotation] = []
		//add each venue annotation to an array
		venues.forEach { (venue) in
			let venueAnnotation = venueLocation(coordinate: CLLocationCoordinate2D(latitude: venue.location.lat, longitude: venue.location.lng), title: venue.name, subtitle: venue.contact.formattedPhone)
			venueAnnotations.append(venueAnnotation)
		}
		self.searchView.searchMap.addAnnotations(venueAnnotations)
	}
}

// MARK: Search Bars (venueSearch (0) and near (1))
extension SearchViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
		if searchBar.tag == 0 { self.venueSearchTerm = searchBar.text ?? "" }
		if searchBar.tag == 1 { self.near = searchBar.text?.replacingOccurrences(of: " ", with: "%20") ?? ""}
        searchBar.text = ""
	}
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		searchBar.text = ""
	}
}


// MARK: MapView Delegate
extension SearchViewController : MKMapViewDelegate {
//	func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//		<#code#>
//	}
//	func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
//		<#code#>
//	}
//	func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
//		<#code#>
//	}
//	func mapViewDidFailLoadingMap(_ mapView: MKMapView, withError error: Error) {
//		<#code#>
//	}

	//for directions from point to point
//	func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
//		if overlay is MKPolyline {
//			var polylineRenderer = MKPolylineRenderer(overlay: overlay)
//			polylineRenderer.strokeColor = UIColor.blueColor()
//			polylineRenderer.lineWidth = 5
//			return polylineRenderer
//		}
//		return nil
//	}
}

//MARK: Core Location Manager - Delegate
extension SearchViewController :  CLLocationManagerDelegate  {
	func determineMyLocation() {
		locationManager = CLLocationManager()
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.distanceFilter = 1000 //meters
		locationManager.requestAlwaysAuthorization()

		//if user opted in for location services, start updating
		if CLLocationManager.locationServicesEnabled() {
			locationManager.startUpdatingLocation()
		}
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		let userLocation: CLLocation = locations[0]
		print("User latitude = \(userLocation.coordinate.latitude)")
		print("User longitude = \(userLocation.coordinate.longitude)")
		let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
		let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.045, longitudeDelta: 0.045))
		searchView.searchMap.setRegion(region, animated: true)
		searchView.searchMap.showsUserLocation = true
		//        locationManager.stopUpdatingLocation()
	}

	func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
		let region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 100, 100)
		searchView.searchMap.setRegion(region, animated: true)
		searchView.searchMap.showsUserLocation = true
	}

	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("Error: \(error)")
	}
}



//MARK: CollectionView Datasource

