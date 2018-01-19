//  SearchViewController.swift
//  HereAndThere
//  Created by Winston Maragh on 1/16/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.

import UIKit
import CoreLocation
import MapKit
//import SnapKit
//import Alamofire

class SearchViewController: UIViewController {

	//create instance of custom View
	var searchView = SearchView()

	// MARK: Properties
	var locationManager: CLLocationManager! //instance of Location Manager
	var currentLocation: CLLocation!
	var latLong: String = ""
	var near: String = ""
	var venueSearchTerm = "" {
		didSet { loadVenues(search: venueSearchTerm, latLong: latLong, near: near) }
	}
	var venues: [Venue] = [] {
		didSet {
			DispatchQueue.main.async {
				self.searchView.collectionView.reloadData()
				self.addVenueLocationsOnMap()
			}
		}
	}
	var venuesPhotos: [PhotosItem] = [] {
		didSet {
			DispatchQueue.main.async {
				self.searchView.collectionView.reloadData()
			}
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
		searchView.citySearchBar.delegate = self
		searchView.searchMap.delegate = self

		//Setup
		setupUI()
		setupLocation()
		loadVenues(search: "chinese", latLong: latLong, near: near) //load default venues on startup
//		PhotoAPIClient.manager.getVenuePhotos(venueID: "525eeb3811d2c49bf03e23ec") { (error, onlinePhotos) in
//			if let error = error { print(error) }
//			if let onlinePhotos = onlinePhotos { self.venuesPhotos = onlinePhotos }
//		}
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		setupLocation()
	}

	//Custom Methods
	func setupUI(){
		self.view.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.9, alpha: 1.0)
		setupNavigationBar()
	}
	func setupLocation(){
		determineMyLocation()
		currentLocation = CLLocation(latitude: 40.743034, longitude: -73.941832)
		latLong = "\(currentLocation.coordinate.latitude),\(currentLocation.coordinate.longitude)"
	}
	func setupNavigationBar() {
		navigationItem.title = "Search"

		//navigation Search bar
		let venueSearchBar = UISearchBar()
		venueSearchBar.showsCancelButton = false
		venueSearchBar.placeholder = "Search for Venue"
		venueSearchBar.tag = 0
		venueSearchBar.delegate = self
		self.navigationItem.titleView = venueSearchBar

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
	func loadVenues(search: String, latLong: String, near: String){
		SearchAPIClient.manager.getVenues(venueSearch: search, latLong: latLong, near: near, completion: { (error, onlineVenues) in
			if let error = error { print("Error loading Venues in View Controller: \(error)")}
			if let onlineVenues = onlineVenues {
				self.venues = onlineVenues
			}
		})
	}

	func addVenueLocationsOnMap(){
		var venueAnnotations: [MKAnnotation] = []
		//add each venue annotation to an array
		venues.forEach { (venue) in
			let venueAnnotation = venueLocation(coordinate: CLLocationCoordinate2D(latitude: venue.location.lat, longitude: venue.location.lng), title: venue.name, subtitle: venue.contact.formattedPhone)
			venueAnnotations.append(venueAnnotation)
		}
		let point3 = venueLocation(coordinate: CLLocationCoordinate2D(latitude: 40.7438553, longitude: -73.9347052), title: "Laguardia College", subtitle: "Cuny College")
		venueAnnotations.append(point3) //test location
		self.searchView.searchMap.addAnnotations(venueAnnotations)
	}
}


// MARK: Search Bars (venueSearch (0) and near (1))
extension SearchViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
		if searchBar.tag == 0 { self.venueSearchTerm = searchBar.text ?? "" }
		if searchBar.tag == 1 { self.near = searchBar.text ?? ""}
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
		let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035))
		//        let userAnnotation = MKPointAnnotation()
		//        userAnnotation.coordinate = userLocation.coordinate
		//        userAnnotation.title = "This is us!"
		//        mapView.addAnnotation(userAnnotation)
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
extension SearchViewController : UICollectionViewDataSource {
	//# of sections
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	//# of items in section
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return venues.count
	}
	//setup for cell
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCVCell", for: indexPath) as! SearchCVCell

		//altering Cell shape & border
		customCell.layer.cornerRadius = 5.0
		customCell.layer.borderColor = UIColor.blue.cgColor
		customCell.layer.borderWidth = 1.0

		//setup attributes
		customCell.backgroundColor = UIColor.clear //cell color

		// property
		let venue = venues[indexPath.row]

		//get image
		customCell.imageView.image = nil

		//Get Photo Data from venue ID
//		PhotoAPIClient.manager.getVenuePhotos(venueID: venue.id) { (error, onlineItems) in
//			if let error = error { print("Error loading Venues in View Controller: \(error)")}
//			if let photoItem = onlineItems { self.venues = onlineVenues }
//		}

//		let imageStr = "\(prefix)\(size)\(suffix)"

		//call ImageHelper
			ImageHelper.manager.getImage(from: "https://igx.4sqi.net/img/general/300x500/5163668_xXFcZo7sU8aa1ZMhiQ2kIP7NllD48m7qsSwr1mJnFj4.jpg",
																	 completionHandler: { customCell.imageView.image = $0; customCell.setNeedsLayout();},
																	 errorHandler: {print($0)})

		return customCell
	}
}


//MARK: CollectionView - Delegate Flow Layout
extension SearchViewController : UICollectionViewDelegateFlowLayout {
	//Layout - Size for item
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let numCells: CGFloat = 4
		let numSpaces: CGFloat = numCells + 1
		let screenWidth = UIScreen.main.bounds.width
		return CGSize(width: (screenWidth - (cellSpacing * numSpaces)) / numCells, height: collectionView.bounds.height - (cellSpacing * 2))
	}
	//Layout - Inset for section
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
	}
	//Layout - line spacing
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return cellSpacing + 5
	}
	//Layout - inter item spacing
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return cellSpacing
	}
}


//MARK: CollectionView Delegate
extension SearchViewController : UICollectionViewDelegate {
	//action for selected item
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		//		let venue = venues[indexPath.row]
		let detailVC = DetailViewController()
		detailVC.modalPresentationStyle = .overCurrentContext
		detailVC.modalTransitionStyle = .crossDissolve
		navigationController?.present(detailVC, animated: true, completion: nil)

		//		let detailVC = DetailViewController()
		//		self.navigationController?.pushViewController(detailVC, animated: true)
	}
}



//for directions
//	func showRouteOnMap() {
//		let request = MKDirectionsRequest()
//		request.source = MKMapItem(placemark: MKPlacemark(coordinate: annotation1.coordinate, addressDictionary: nil))
//		request.destination = MKMapItem(placemark: MKPlacemark(coordinate: annotation2.coordinate, addressDictionary: nil))
//		request.requestsAlternateRoutes = true
//		request.transportType = .Automobile
//
//		let directions = MKDirections(request: request)
//
//		directions.calculateDirectionsWithCompletionHandler { [unowned self] response, error in
//			guard let unwrappedResponse = response else { return }
//
//			if (unwrappedResponse.routes.count > 0) {
//				self.mapView.addOverlay(unwrappedResponse.routes[0].polyline)
//				self.mapView.setVisibleMapRect(unwrappedResponse.routes[0].polyline.boundingMapRect, animated: true)
//			}
//		}
//	}


//	func checkUserPermissions(){
//		//checking user authorization permissions
//			if CLLocationManager.locationServicesEnabled() { 		//if location is enabled
//					if locationManager == nil {
//						//set a new location Manager instance
//						locationManager = CLLocationManager()
//					}
//					locationManager?.requestWhenInUseAuthorization()
//					locationManager.delegate = self
//					locationManager.desiredAccuracy = kCLLocationAccuracyBest
//					locationManager.requestAlwaysAuthorization()
//					locationManager.startUpdatingLocation()
//			} else { //not enabled - asks for permission
//				//TO-DO:
//			}
//	}
