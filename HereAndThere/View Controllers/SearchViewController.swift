//  SearchViewController.swift
//  HereAndThere
//  Created by Winston Maragh on 1/16/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.

import UIKit
import CoreLocation
import MapKit
//import MaterialComponents.MaterialCollections
//import MaterialComponents.MaterialCollectionLayoutAttributes
//import MaterialComponents.MDCShadowLayer

class SearchViewController: UIViewController {

	//MARK: View Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(searchView)

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
		let locationCheck = LocationService.manager.checkForLocationServices()

		//        //Gestures
		//        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
		//        swipeDown.direction = UISwipeGestureRecognizerDirection.down
		//        searchView.collectionView.addGestureRecognizer(swipeDown)
		//
		//        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
		//        swipeUp.direction = UISwipeGestureRecognizerDirection.up
		//        searchView.collectionView.addGestureRecognizer(swipeUp)
	}


	// MARK: create instance of SearchView
	var searchView = SearchView()
    //	let appBar = MDCAppBar()

	// MARK: Properties
	var near: String = ""
	private var venues = [Venue]() {
		didSet {
			addAnnotationsToMap()
		}
	}
	private var annotationsForVenues = [MKAnnotation]()
	private var currentSelectedVenue: Venue!

	private var selectedVenue: (Venue, [UIImage])!
	private var selectedVenuePhotos: [UIImage]!

	private var currentSelectedVenuePhoto: UIImage!
	private var currentSelectedVenuePhotosObject = [PhotoObject]()

	let cellSpacing: CGFloat = 1.0 //cellspacing Property for collectionView Flow Layout


	//Custom Methods
	fileprivate func setupLocation(){
		LocationService.manager.determineMyLocation()
	}
	fileprivate func setupNavigationBar() {
		navigationItem.title = "Search"
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.largeTitleDisplayMode = .always
		navigationItem.titleView = searchView.venueSearchBar

		//right bar button for toggling between map & list
		let toggleBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(toggleListAndMap))
		navigationItem.rightBarButtonItem = toggleBarItem
	}
	@objc func toggleListAndMap() {
        let resultsVC = ResultsListViewController(venues: venues)
        self.navigationController?.pushViewController(resultsVC, animated: true)
	}

	private func addAnnotationsToMap(){
		// creating annotations
		venues.forEach { (venue) in
			let venueAnnotation = venueLocation(coordinate: CLLocationCoordinate2D(latitude: venue.location.lat, longitude: venue.location.lng), title: venue.name, subtitle: venue.contact.formattedPhone ?? "")
			annotationsForVenues.append(venueAnnotation)
		}
		// add annotations to map
		DispatchQueue.main.async {
			self.searchView.searchMap.addAnnotations(self.annotationsForVenues)
			self.searchView.searchMap.showAnnotations(self.annotationsForVenues, animated: true)
			self.searchView.collectionView.reloadData()
		}
	}

	private func callNumber(phoneNumber: String) {
//		if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
		if let phoneCallURL = URL(string: "telprompt://\(phoneNumber)") {
			if (UIApplication.shared.canOpenURL(phoneCallURL)) {
				UIApplication.shared.open(phoneCallURL, options: [:], completionHandler: nil)
			}
		}
	}
}


// MARK: SearchBar Delegate
extension SearchViewController: UISearchBarDelegate {
	//search - enter press
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder() //resign keyboard

		// validate venue search
		guard let venueSearch = searchView.venueSearchBar.text else {
			//Venue text is empty - prompt user to enter a venue
			let alertController = UIAlertController(title: "What Venue are you looking for?", message: "Please enter a Venue", preferredStyle: .alert)
			let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
			alertController.addAction(okAction)
			present(alertController, animated: true, completion: nil)
			return
		}
		guard !venueSearch.isEmpty else { print("venue text is empty"); return }
		guard let encodedVenueSearch = venueSearch.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { print("spaces not allowed"); return }

		//validate
		guard let nearSearch = searchView.citySearchBar.text else {return}
		guard let encodedNearSearch = nearSearch.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { print("spaces not allowed"); return }

		//API Call to get venues
		SearchAPIClient.manager.getVenues(from: encodedVenueSearch, coordinate: "\(searchView.searchMap.userLocation.coordinate.latitude),\(searchView.searchMap.userLocation.coordinate.longitude)", near: encodedNearSearch) { (OnlineVenues) in
			print(self.searchView.searchMap.userLocation.coordinate.latitude)
			print(self.searchView.searchMap.userLocation.coordinate.longitude)
			self.venues.removeAll()
			self.searchView.searchMap.removeAnnotations(self.annotationsForVenues)
			self.annotationsForVenues.removeAll()
			self.venues = OnlineVenues
		}
	}
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		searchBar.text = ""
	}
}




// MARK: MAPVIEW Delegate
extension SearchViewController : MKMapViewDelegate {
	//view for each annotation
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		//this keeps the user location point as a default blue dot. Ignore the userlocation.
		if annotation is MKUserLocation { return nil }

		//setup annotation view for map - we can fully customize the marker
		var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "PlaceAnnotationView") as? MKMarkerAnnotationView

		//setup annotation view
		if annotationView == nil {
			annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "PlaceAnnotationView")
			annotationView?.canShowCallout = true
			annotationView?.animatesWhenAdded = true

			//right callout
			annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)

			//left callout
			let imageView = UIImageView.init(frame: CGRect(origin: CGPoint(x:0,y:0),size:CGSize(width:30,height:30)))
			imageView.image = UIImage(named: "phone")
			annotationView!.leftCalloutAccessoryView = imageView
		} else { //display as is
			annotationView?.annotation = annotation
		}
		return annotationView
	}

	//callout tapped/selected
	func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {

		//go to detailViewController
        let detailVC = DetailViewController(venue: currentSelectedVenue, image: currentSelectedVenuePhoto)
		navigationController?.pushViewController(detailVC, animated: true)

		//Phone call
		if let phoneNumber = currentSelectedVenue.contact.phone {
			callNumber(phoneNumber: phoneNumber)
		}
	}

	//didSelect - setting currentSelected Venue
	func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
		//find venue selected
		let index = annotationsForVenues.index{$0 === view.annotation} //where they match, pass the index
		guard let annotationIndex = index else {print ("index is nil"); return }
		let venue = venues[annotationIndex]
		currentSelectedVenue = venue
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
			self.currentSelectedVenuePhotosObject = onlinePhotoObjects
			if !self.currentSelectedVenuePhotosObject.isEmpty {
				let imageStr = "\(self.currentSelectedVenuePhotosObject[0].prefix)100x100\(self.currentSelectedVenuePhotosObject[0].suffix)"
				ImageHelper.manager.getImage(from: imageStr, completionHandler: { (onlineImage) in
					customCell.imageView.image = nil
					customCell.imageView.image = onlineImage
					self.currentSelectedVenuePhoto = onlineImage
					customCell.setNeedsLayout()
				}, errorHandler: {print($0)})
			} else {
				customCell.imageView.image = #imageLiteral(resourceName: "placeholder-image")
			}
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
        let detailVC = DetailViewController(venue: venue, image: currentSelectedVenuePhoto)
		navigationController?.pushViewController(detailVC, animated: true)
	}
}


//BONUS Methods
//Gesture Method
//	@objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
//		if let swipeGesture = gesture as? UISwipeGestureRecognizer {
//			switch swipeGesture.direction {
//				case UISwipeGestureRecognizerDirection.down:
//					print("swipped down")
//					hideCollectionView()
//				case UISwipeGestureRecognizerDirection.up:
//					print("swipped up")
//					showCollectionView()
//				default:
//					break
//			}
//		}
//	}

//	func hideCollectionView() {
//		UIView.animate(withDuration: 0.5) {
//			self.searchView.collectionViewBottomConstraint.constant = 120
//			self.view.layoutIfNeeded()
//		}
//	}

//	func showCollectionView() {
//		UIView.animate(withDuration: 0.5) {
//				self.searchView.collectionViewBottomConstraint.isActive = false
//            self.searchView.collectionViewBottomConstraint = self.searchView.containerView.bottomAnchor.constraint(equalTo: self.searchView.safeAreaLayoutGuide.bottomAnchor)
//            self.searchView.collectionViewBottomConstraint.isActive = true
//            self.view.layoutIfNeeded()
//        }
//    }



//for directions
//    func showRouteOnMap() {
//        let request = MKDirectionsRequest()
//        request.source = MKMapItem(placemark: MKPlacemark(coordinate: annotation1.coordinate, addressDictionary: nil))
//        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: annotation2.coordinate, addressDictionary: nil))
//        request.requestsAlternateRoutes = true
//        request.transportType = .Automobile
//
//        let directions = MKDirections(request: request)
//
//        directions.calculateDirectionsWithCompletionHandler { [unowned self] response, error in
//            guard let unwrappedResponse = response else { return }
//
//            if (unwrappedResponse.routes.count > 0) {
//                self.mapView.addOverlay(unwrappedResponse.routes[0].polyline)
//                self.mapView.setVisibleMapRect(unwrappedResponse.routes[0].polyline.boundingMapRect, animated: true)
//            }
//        }
//    }


//Make Phone Call
//		guard let number = URL(string: "tel://61234567890") else { return }
//		UIApplication.shared.open(number)

//		if let phoneCallURL:URL = URL(string: "tel:\(currentSelectedVenue.contact.phone!)") {
//			let application:UIApplication = UIApplication.shared
//			if (application.canOpenURL(phoneCallURL)) {
//				let alertController = UIAlertController(title: "MyApp", message: "Are you sure you want to call \n\(self.strPhoneNumber)?", preferredStyle: .alert)
//				let yesPressed = UIAlertAction(title: "Yes", style: .default, handler: { (action) in
//					application.openURL(phoneCallURL)
//				})
//				let noPressed = UIAlertAction(title: "No", style: .default, handler: { (action) in
//
//				})
//				alertController.addAction(yesPressed)
//				alertController.addAction(noPressed)
//				present(alertController, animated: true, completion: nil)
//			}
//		}
//		UIApplication.shared.open(number, options: [:], completionHandler: nil)
