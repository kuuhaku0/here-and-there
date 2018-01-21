//  SearchViewController.swift
//  HereAndThere
//  Created by Winston Maragh on 1/16/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.

import UIKit
import CoreLocation
import MapKit

class SearchViewController: UIViewController {

	//MARK: View Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(searchView)  //add customView to access properties

		//Delegates and Datasource
		searchView.venueSearchBar.delegate = self
		searchView.citySearchBar.delegate = self
		searchView.searchMap.delegate = self
		searchView.collectionView.delegate = self
		searchView.collectionView.dataSource = self

		//Setup
		self.view.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.9, alpha: 1.0)
		setupNavigationBar()
		setupLocation()
		let _ = LocationService.manager.checkForLocationServices()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
//		setupLocation()
	}


	// MARK: create instance of SearchView
	var searchView = SearchView()

	// MARK: Properties
	var locationManager: CLLocationManager! //instance of Location Manager
	var currentLocation: CLLocation!
	var latLong: String = ""
	var near: String = ""

	private var venues = [Venue]() {
		didSet {
			addAnnotationsToMap()
		}
	}
	private var annotations = [MKAnnotation]()
	private var currentSelectedVenue: Venue!
	private var currentSelectedVenuePhoto: UIImage!
	private var currentSelectedVenuePhotos = [PhotoObject]() {
		didSet {
			//            self.searchView.collectionView.reloadData()
		}
	}

	let cellSpacing: CGFloat = 1.0 //cellspacing Property for collectionView Flow Layout





	//Custom Methods
	func setupLocation(){
		determineMyLocation()
		currentLocation = CLLocation(latitude: 40.743034, longitude: -73.941832)
		latLong = "\(currentLocation.coordinate.latitude),\(currentLocation.coordinate.longitude)"
	}
	func setupNavigationBar() {
		navigationItem.title = "Search for Venue"
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.largeTitleDisplayMode = .always
		navigationItem.titleView = searchView.venueSearchBar

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
        SearchAPIClient.manager.getVenues(from: search, coordinate: latLong, near: near) { self.venues = $0 }
    }

	func addAnnotationsToMap(){
		// creating annotations
		venues.forEach { (venue) in
				//	let venueAnnotation = venueLocation(coordinate: CLLocationCoordinate2D(latitude: venue.location.lat, longitude: venue.location.lng), title: venue.name, subtitle: venue.contact.formattedPhone)
			let venueAnnotation = MKPointAnnotation()
			venueAnnotation.coordinate = CLLocationCoordinate2DMake(venue.location.lat, venue.location.lng)
			venueAnnotation.title = venue.name
//			venueAnnotation.subtitle = venue.contact.formattedPhone
			annotations.append(venueAnnotation)
		}
		// add annotations to map
		DispatchQueue.main.async {
			self.searchView.searchMap.addAnnotations(self.annotations)
			self.searchView.searchMap.showAnnotations(self.annotations, animated: true)
			self.searchView.collectionView.reloadData()
		}
	}

}


// MARK: SearchBar Delegate
extension SearchViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()

		// validate venue search
		guard let text = searchView.venueSearchBar.text else { print("venue search is nil"); return }
		guard !text.isEmpty else { print("venue text is empty"); return }
		guard let encodedVenueSearch = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { print("spaces not allowed"); return }

		// check for empty address field. i.e placeholder text
		var address: String!
		if let value = searchView.citySearchBar.text {
			if value.isEmpty { address = nil}
			else { address = value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)}
		}

		//API Call to get venues
		SearchAPIClient.manager.getVenues(from: encodedVenueSearch, coordinate: "\(currentLocation.coordinate.latitude),\(currentLocation.coordinate.longitude)", near: near) { (OnlineVenues) in
			self.venues.removeAll()
			self.searchView.searchMap.removeAnnotations(self.annotations)
			self.annotations.removeAll()
			self.venues = OnlineVenues
		}
	}
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		searchBar.text = ""
	}
}


// MARK: MapView Delegate
extension SearchViewController : MKMapViewDelegate {
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		//gets called on every location on the map

		//this keeps the user location point as a default blue dot. Ignore the userlocation.
		if annotation is MKUserLocation { return nil }

		//setup annotation view for map - we can fully customize the marker
		var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "PlaceAnnotationView") as? MKMarkerAnnotationView

		//setup annotation view
		if annotationView == nil {
			annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "PlaceAnnotationView")
			annotationView?.canShowCallout = true
			annotationView?.animatesWhenAdded = true

//			let index = annotations.index{$0 === annotation } //class comparison
//			if let annotationIndex = index {
//				let venue = venues[annotationIndex]
////				annotationView?.glyphText = venue.contact.phone
//			}
			annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)

			//Callout setup
			//add an image to callout
			let imageView = UIImageView.init(frame: CGRect(origin: CGPoint(x:0,y:0),size:CGSize(width:30,height:30)))
//				imageView.image = UIImage(named: "coffee")
//				imageView.image = UIImage(image: currentSelectedVenuePhoto)
			imageView.image = currentSelectedVenuePhoto


				annotationView!.leftCalloutAccessoryView = imageView

//			annotationView?.leftCalloutAccessoryView = UIImageView(image: currentSelectedVenuePhoto)
//			annotationView?.markerTintColor = UIColor.green
//			annotationView?.image = currentSelectedVenuePhoto

		} else {
			annotationView?.annotation = annotation
		}
		return annotationView
	}

	//Setting currentSelected Venue
	func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
		//find venue selected
		let index = annotations.index{$0 === view.annotation} //where they match, pass the index
		guard let annotationIndex = index else {print ("index is nil"); return }
		let venue = venues[annotationIndex]
		currentSelectedVenue = venue
	}

	func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
		let detailVC = DetailViewController(venue: currentSelectedVenue)
		navigationController?.pushViewController(detailVC, animated: true)
	}

//	func mapViewDidFailLoadingMap(_ mapView: MKMapView, withError error: Error) {
//		<#code#>
//	}

	//for directions from point to point
	func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
		if overlay is MKPolyline {
			var polylineRenderer = MKPolylineRenderer(overlay: overlay)
			polylineRenderer.strokeColor = UIColor.blue
			polylineRenderer.lineWidth = 5
			return polylineRenderer
		}
		return nil
	}
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
		customCell.nameLabel.text = venue.name

		PhotoAPIClient.manager.getVenuePhotos(venueID: venue.id) { (onlinePhotoObjects) in
			self.currentSelectedVenuePhotos = onlinePhotoObjects
			//"https://igx.4sqi.net/img/general/300x500/5163668_xXFcZo7sU8aa1ZMhiQ2kIP7NllD48m7qsSwr1mJnFj4.jpg"
			let imageStr = "\(self.currentSelectedVenuePhotos[0].prefix)100x100\(self.currentSelectedVenuePhotos[0].suffix)"
			ImageHelper.manager.getImage(from: imageStr, completionHandler: { (onlineImage) in
				customCell.imageView.image = nil
				customCell.imageView.image = onlineImage
				self.currentSelectedVenuePhoto = onlineImage
				customCell.setNeedsLayout()
			}, errorHandler: {print($0)})
		}
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
		let venue = venues[indexPath.row]
		let detailVC = DetailViewController(venue: venue)
		navigationController?.pushViewController(detailVC, animated: true)
	}
}



//for directions using mapKit
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
