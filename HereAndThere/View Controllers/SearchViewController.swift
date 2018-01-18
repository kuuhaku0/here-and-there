//  SearchViewController.swift
//  HereAndThere
//  Created by Winston Maragh on 1/16/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.

import UIKit
import CoreLocation
import MapKit


//TO DO - install SnapKit (programmatic layout)
//TO DO - install AlamoFire (networking)
//TO-DO:
//		MKAnnotation
//		MKAnnotationView = visual representation of one of the annotation
//		MKPinAnnotationView
//		MKPointAnnotation
//		MKMarkerAnnotationView


class SearchViewController: UIViewController {

	//create instance of custom View
	var searchView = SearchView()

	// MARK: Properties

	//Location for Search
	var locationManager: CLLocationManager! //instance of Location Manager
	var annotation: MKAnnotation!

	//Search
	var searchController: UISearchController!
	var localSearchRequest: MKLocalSearchRequest!
	var localSearch: MKLocalSearch!
	var localSearchResponse: MKLocalSearchResponse!
	
	var currentLocation: CLLocation!
	var latLong: String = ""
	var near: String = ""
	var venueSearchTerm = "" {
		didSet {
			loadVenues(search: venueSearchTerm, latLong: latLong, near: near)
		}
	}
	var venues: [Venue] = [] {
		didSet {
			DispatchQueue.main.async {
				self.searchView.collectionView.reloadData()
//				self.addVenueLocationsOnMap()
			}
		}
	}
	var venuesPhotos: [PhotosItem] = []{
		didSet {
			DispatchQueue.main.async {
				self.searchView.collectionView.reloadData()
				//				self.addVenueLocationsOnMap()
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
		PhotoAPIClient.manager.getVenuePhotos(venueID: "525eeb3811d2c49bf03e23ec") { (error, onlinePhotos) in
			if let error = error { print(error) }
			if let onlinePhotos = onlinePhotos { self.venuesPhotos = onlinePhotos }
		}
	}

//	override func viewWillLayoutSubviews() {
//		super.viewWillLayoutSubviews()
//	}
//	override func viewWillAppear(_ animated: Bool) {
//		super.viewWillAppear(animated)
////		determineMyCurrentLocation() //core location
//	}

	//Custom Methods
	func setupUI(){
		self.view.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.9, alpha: 1.0)
		setupNavigationBar()
	}
	func setupLocation(){
		currentLocation = CLLocation(latitude: 40.743034, longitude: -73.941832)
		latLong = "\(currentLocation.coordinate.latitude),\(currentLocation.coordinate.longitude)"
		centerLocationOnMap(location: currentLocation) //center current Location on map
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
		//when bar button is pressed transition to a Results List VC with tableview layout
		let resultsDVC = ResultsViewController()
		self.navigationController?.pushViewController(resultsDVC, animated: true)
	}
	@objc func searchButtonAction(){
		if searchController == nil {
			searchController = UISearchController(searchResultsController: nil)
		}
		searchController.hidesNavigationBarDuringPresentation = false
		self.searchController.searchBar.delegate = self
		present(searchController, animated: true, completion: nil)
	}

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
//
//			}
//	}

	func checkUserLocationPermission(){
		//this is a class property. Not available on instance
		switch CLLocationManager.authorizationStatus() {
			case .authorizedAlways, .authorizedWhenInUse:
				print("Authorized")
			case .denied:
				print("Denied")
				//opens phone Settings so user can authorize permission
				guard let validSettingsURL: URL = URL(string: UIApplicationOpenSettingsURLString) else {return}
				UIApplication.shared.open(validSettingsURL, options: [:], completionHandler: nil)
			case .notDetermined:
				print("Not Determined")
				locationManager.requestWhenInUseAuthorization()
			case .restricted:
				print("Restricted")
		}
	}

	//load the venues (API Call) in venues array
	func loadVenues(search: String, latLong: String, near: String){
		//check if user inputed a different location city. Use this as location
		if near != "" {
			SearchAPIClient.manager.getVenues(venueSearch: search, latLong: latLong) { (error, onlineVenues) in
				if let error = error { print("Error loading Venues in View Controller: \(error)")}
				if let onlineVenues = onlineVenues { self.venues = onlineVenues }
			}
		} //else ue their current location (assuming its turned on)
		else if latLong != "" {
			SearchAPIClient.manager.getVenues(venueSearch: search, near: near) { (error, onlineVenues) in
				if let error = error { print("Error loading Venues in View Controller: \(error)")}
				if let onlineVenues = onlineVenues { self.venues = onlineVenues }
			}
		}
	}

	//Add pins for each Venue Location (after getting venues)
	func addVenueLocationsOnMap(){
		var locationArray: [venueLocation] = []
		venues.forEach { (venue) in
		 var coordinate	= CLLocationCoordinate2D(latitude: venue.location.lat, longitude: venue.location.lng)
			var newLocation = venueLocation(coordinate: coordinate, title: venue.name, subtitle: venue.contact.phone!)
			locationArray.append(newLocation)
		}
		searchView.searchMap.addAnnotations(locationArray)
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

}


// MARK: Search Bars (venueSearch (0) and near (1))
extension SearchViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
		if searchBar.tag == 0 { self.venueSearchTerm = searchBar.text ?? "" }
		if searchBar.tag == 1 { self.near = searchBar.text ?? "" }
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
	func centerLocationOnMap(location: CLLocation){
		//creates a new MKCoordinateRegion with specified coordinate and distance
		let coordinateRegion = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 1500, 1500) //meters
		searchView.searchMap.setRegion(coordinateRegion, animated: true) //display the region
	}

	func determineMyCurrentLocation() {
		locationManager = CLLocationManager()
		locationManager.delegate = self
		//locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
		locationManager.distanceFilter = 200 //meters
		locationManager.requestAlwaysAuthorization()

		if CLLocationManager.locationServicesEnabled() {
			locationManager.startUpdatingLocation()
			//locationManager.startUpdatingHeading()
		}
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		let userLocation: CLLocation = locations[0] as CLLocation
		// Call stopUpdatingLocation() to stop listening for location updates,
		// other wise this function will be called every time when user location changes.
		// manager.stopUpdatingLocation()
		print("user latitude = \(userLocation.coordinate.latitude)")
		print("user longitude = \(userLocation.coordinate.longitude)")
	}

	func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
		let region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 100, 100)

		//add Annotation
//		let region = MKCoordinateRegion(center: center, span: <#T##MKCoordinateSpan#>)
//		let userAnnotation = MKPointAnnotation()
//		userAnnotation.coordinate = userLocation.coordinate
//		userAnnotation.title = "This is us"
//		userAnnotation.subtitle = "Yay subtitle"
//		searchView.searchMap.addAnnotation(userAnnotation)
		searchView.searchMap.setRegion(region, animated: true)
		searchView.searchMap.showsUserLocation = true

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
		if venues.isEmpty {return 7}
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
//		let venue = venues[indexPath.row]

		//get image
		customCell.imageView.image = nil

		//Get Photo Data from venue ID

//		PhotoAPIClient.manager.getVenuePhotos(venueID: venue.id) { (error, onlineItems) in
//			if let error = error { print("Error loading Venues in View Controller: \(error)")}
//			if let photoItem = onlineItems { self.venues = onlineVenues }
//		}

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
