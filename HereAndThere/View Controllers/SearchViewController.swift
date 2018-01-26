//  SearchViewController.swift
//  HereAndThere
//  Created by Winston Maragh on 1/16/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.

import UIKit
import CoreLocation
import MapKit
import SVProgressHUD
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
        searchView.nearSearchBar.delegate = self
        searchView.searchMap.delegate = self
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
        
        //Setup
        self.view.backgroundColor = UIColor(red: 1/255, green: 163/255, blue: 225/255, alpha: 1)
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
    private var searchView = SearchView()
    //    let appBar = MDCAppBar()
    
    // MARK: Properties
    private var near: String = ""
    private var venues = [Venue]() {
        didSet {
            addAnnotationsToMap()
        }
    }
    fileprivate var annotationsForVenues = [MKAnnotation]()
    
    fileprivate var selectedVenue: (Venue, [PhotoObject])!
    fileprivate var selectedVenuePhotoObjects = [PhotoObject]()
    fileprivate var selectedVenuePhoto: UIImage!
    fileprivate var selectedVenuePhotos: [UIImage]!
    
    fileprivate var currentSelectedVenue: Venue!
    fileprivate var currentSelectedVenuePhoto: UIImage!
    fileprivate var currentSelectedVenuePhotosObject = [PhotoObject]()
    
    fileprivate let cellSpacing: CGFloat = 1.0 //cellspacing Property for collectionView Flow Layout
    
    
    //Custom Methods
    fileprivate func setupLocation(){
        LocationService.manager.determineMyLocation()
    }
    fileprivate func setupNavigationBar() {
        navigationItem.title = "Search"
        //        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.titleView = searchView.venueSearchBar
        
        //right bar button for toggling between map & list
        let toggleBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "database"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(toggleListAndMap))
        toggleBarItem.tintColor = UIColor(red: 6/255, green: 101/255, blue: 143/255, alpha: 1)
        toggleBarItem.style = .plain
        navigationItem.rightBarButtonItem = toggleBarItem
    }
    @objc private func toggleListAndMap() {
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
    
    //    private func callNumber(phoneNumber: String) {
    ////        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
    //        if let phoneCallURL = URL(string: "telprompt://\(phoneNumber)") {
    //            if (UIApplication.shared.canOpenURL(phoneCallURL)) {
    //                UIApplication.shared.open(phoneCallURL, options: [:], completionHandler: nil)
    //            }
    //        }
    //    }
    
    @objc private func callNumber() {
        print("Attempting phone call")
        //        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
        if let phoneCallURL = URL(string: "telprompt://\(String(describing: currentSelectedVenue.contact.phone))") {
            if (UIApplication.shared.canOpenURL(phoneCallURL)) {
                UIApplication.shared.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
}


// MARK: SearchBar Delegate
extension SearchViewController: UISearchBarDelegate {
    //search - enter press
    internal func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        //validate venue search
        guard let venueSearch = searchView.venueSearchBar.text else {return}
        guard !venueSearch.isEmpty else {
            let alertController = UIAlertController(title: "Enter a Venue", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        guard let encodedVenueSearch = venueSearch.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        //validate near search
        guard let nearSearch = searchView.nearSearchBar.text else {return}
        guard let encodedNearSearch = nearSearch.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        //API Call to get venues
        SearchAPIClient.manager.getVenues(from: encodedVenueSearch, coordinate: "\(searchView.searchMap.userLocation.coordinate.latitude),\(searchView.searchMap.userLocation.coordinate.longitude)", near: encodedNearSearch) { (OnlineVenues) in
            self.venues.removeAll()
            self.searchView.searchMap.removeAnnotations(self.annotationsForVenues)
            self.annotationsForVenues.removeAll()
            self.venues = OnlineVenues
        }
        searchView.nearSearchBar.isHidden = true
    }
    internal func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchView.nearSearchBar.isHidden = true
    }
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        searchView.nearSearchBar.isHidden = true
        
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchView.nearSearchBar.isHidden = false
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchView.nearSearchBar.isHidden = true
    }
}




// MARK: MAPVIEW Delegate
extension SearchViewController : MKMapViewDelegate {
    //view for each annotation
    internal func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //this keeps the user location point as a default blue dot.
        if annotation is MKUserLocation { return nil }
        
        //setup annotation view for map - we can fully customize the marker
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "PlaceAnnotationView") as? MKMarkerAnnotationView
        
        //setup annotation view
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "PlaceAnnotationView")
            
            //right callout
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            //left callout
            let imageView = UIImageView.init(frame: CGRect(origin: CGPoint(x:0,y:0),size:CGSize(width:30,height:30)))
            imageView.clipsToBounds = true
            imageView.image = UIImage(named: "phone")
            annotationView!.leftCalloutAccessoryView = imageView
            
            annotationView?.canShowCallout = true
            annotationView?.animatesWhenAdded = true
            annotationView?.markerTintColor = UIColor(red: 238/255, green: 83/255, blue: 80/255, alpha: 1)
            annotationView?.isHighlighted = true
            
        } else { //display as is
            annotationView?.annotation = annotation
        }
        searchView.nearSearchBar.isHidden = true
        return annotationView
    }
    
    //callout tapped/selected
    internal func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        searchView.nearSearchBar.isHidden = true
        if control == view.rightCalloutAccessoryView {
            control.addTarget(self, action: #selector(callNumber), for: UIControlEvents.allTouchEvents)     //Phone call
        }
        if control == view.leftCalloutAccessoryView {
            control.addTarget(self, action: #selector(callNumber), for: UIControlEvents.allTouchEvents)     //Phone call
        }
        
        //go to detailViewController
        let detailVC = DetailViewController(venue: currentSelectedVenue, image: currentSelectedVenuePhoto)
        navigationController?.pushViewController(detailVC, animated: true)
        searchView.nearSearchBar.isHidden = true
    }
    
    
    //didSelect - setting currentSelected Venue
    internal func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //to change color on annotation already selected
        if let view = view as? MKMarkerAnnotationView {view.markerTintColor = UIColor.lightGray}
        //find venue selected - where they match, pass the index
        let index = annotationsForVenues.index{$0 === view.annotation}
        guard let annotationIndex = index else {print ("index is nil"); return }
        let venue = venues[annotationIndex]
        currentSelectedVenue = venue
        //        searchView.nearSearchBar.isHidden = true
    }
}




//MARK: CollectionView Datasource
extension SearchViewController : UICollectionViewDataSource {
    //# of sections
    internal func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //# of items in section
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return venues.count
    }
    //setup for cell
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCVCell", for: indexPath) as! SearchCVCell
        
        //altering Cell shape & border
        customCell.layer.cornerRadius = 5.0
        customCell.layer.borderWidth = 3
        customCell.layer.borderColor = UIColor(red: 210/255, green: 215/255, blue: 219/255, alpha: 1).cgColor


		//setup attributes
		customCell.backgroundColor = UIColor.white //cell color
        customCell.indicator.startAnimating()
        customCell.indicator.isHidden = false
        
		// property
		let venue = venues[indexPath.row]
		customCell.nameLabel.text = venue.name
		customCell.addressLabel.text = venue.location.address
		customCell.categoryLabel.text = venue.categories.first?.shortName
		customCell.phoneLabel.text = venue.contact.formattedPhone

		PhotoAPIClient.manager.getVenuePhotos(venueID: venue.id) { (onlinePhotoObjects) in
			self.currentSelectedVenuePhotosObject = onlinePhotoObjects
			if !self.currentSelectedVenuePhotosObject.isEmpty {
				let imageStr = "\(self.currentSelectedVenuePhotosObject[0].prefix)100x100\(self.currentSelectedVenuePhotosObject[0].suffix)"
				ImageHelper.manager.getImage(from: imageStr, completionHandler: { (onlineImage) in
					customCell.imageView.image = nil
					customCell.imageView.image = onlineImage
					self.currentSelectedVenuePhoto = onlineImage
                    customCell.indicator.stopAnimating()
                    customCell.indicator.isHidden = true
					customCell.setNeedsLayout()
				}, errorHandler: {print($0)})
			} else {
				customCell.imageView.image = #imageLiteral(resourceName: "placeholder-image")
                customCell.indicator.stopAnimating()
                customCell.indicator.isHidden = true
			}
		}
		return customCell
	}
// =======
        
//         //setup attributes
//         customCell.backgroundColor = UIColor.white //cell color
//         // property
//         let venue = venues[indexPath.row]
//         customCell.nameLabel.text = venue.name
//         customCell.addressLabel.text = venue.location.address
//         customCell.categoryLabel.text = venue.categories.first?.shortName
//         customCell.phoneLabel.text = venue.contact.formattedPhone
        
//         PhotoAPIClient.manager.getVenuePhotos(venueID: venue.id) { (onlinePhotoObjects) in
//             self.currentSelectedVenuePhotosObject = onlinePhotoObjects
//             if !self.currentSelectedVenuePhotosObject.isEmpty {
//                 let imageStr = "\(self.currentSelectedVenuePhotosObject[0].prefix)100x100\(self.currentSelectedVenuePhotosObject[0].suffix)"
//                 ImageHelper.manager.getImage(from: imageStr, completionHandler: { (onlineImage) in
//                     customCell.imageView.image = nil
//                     customCell.imageView.image = onlineImage
//                     self.currentSelectedVenuePhoto = onlineImage
//                     customCell.setNeedsLayout()
//                 }, errorHandler: {print($0)})
//             } else {
//                 customCell.imageView.image = #imageLiteral(resourceName: "placeholder-image")
//             }
//         }
//         return customCell
//     }
// >>>>>>> qa
}

//MARK: CollectionView - Delegate Flow Layout
extension SearchViewController : UICollectionViewDelegateFlowLayout {
    //Layout - Size for item
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numCells: CGFloat = 2
        let numSpaces: CGFloat = numCells + 1
        let screenWidth = UIScreen.main.bounds.width
        return CGSize(width: (screenWidth - (cellSpacing * numSpaces)) / numCells, height: collectionView.bounds.height - (cellSpacing))
    }
    //Layout - Inset for section
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    //Layout - line spacing
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing + 10
    }
    //Layout - inter item spacing
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
}

//MARK: CollectionView Delegate
extension SearchViewController : UICollectionViewDelegate {
    //action for selected item
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let venue = venues[indexPath.row]
        let detailVC = DetailViewController(venue: venue, image: currentSelectedVenuePhoto)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


//BONUS Methods
//Gesture Method
//    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
//        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
//            switch swipeGesture.direction {
//                case UISwipeGestureRecognizerDirection.down:
//                    print("swipped down")
//                    hideCollectionView()
//                case UISwipeGestureRecognizerDirection.up:
//                    print("swipped up")
//                    showCollectionView()
//                default:
//                    break
//            }
//        }
//    }

//    func hideCollectionView() {
//        UIView.animate(withDuration: 0.5) {
//            self.searchView.collectionViewBottomConstraint.constant = 120
//            self.view.layoutIfNeeded()
//        }
//    }

//    func showCollectionView() {
//        UIView.animate(withDuration: 0.5) {
//                self.searchView.collectionViewBottomConstraint.isActive = false
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
//        guard let number = URL(string: "tel://61234567890") else { return }
//        UIApplication.shared.open(number)

//        if let phoneCallURL:URL = URL(string: "tel:\(currentSelectedVenue.contact.phone!)") {
//            let application:UIApplication = UIApplication.shared
//            if (application.canOpenURL(phoneCallURL)) {
//                let alertController = UIAlertController(title: "MyApp", message: "Are you sure you want to call \n\(self.strPhoneNumber)?", preferredStyle: .alert)
//                let yesPressed = UIAlertAction(title: "Yes", style: .default, handler: { (action) in
//                    application.openURL(phoneCallURL)
//                })
//                let noPressed = UIAlertAction(title: "No", style: .default, handler: { (action) in
//
//                })
//                alertController.addAction(yesPressed)
//                alertController.addAction(noPressed)
//                present(alertController, animated: true, completion: nil)
//            }
//        }
//        UIApplication.shared.open(number, options: [:], completionHandler: nil)
