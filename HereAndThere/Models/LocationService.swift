//  LocationService.swift
//  HereAndThere
//  Created by C4Q on 1/19/18.
//  Copyright © 2018 HereAndThere. All rights reserved.


import Foundation
import CoreLocation

class LocationService: NSObject {

	// MARK: view Lifecycle
	private override init() {
		super.init() //whenever you override you should call super
		locationManager = CLLocationManager()
		locationManager.delegate = self
	}
	static let manager = LocationService()

	private var locationManager: CLLocationManager!

}

//MARK: Helper functions
extension LocationService {
	public func checkForLocationServices() -> CLAuthorizationStatus {
		var status: CLAuthorizationStatus!

		//check if location services is enabled
		if CLLocationManager.locationServicesEnabled() {
			print("location services available")
			switch CLLocationManager.authorizationStatus() {
			case .notDetermined:
				print("notDetermined")
				locationManager.requestWhenInUseAuthorization()
				status = CLAuthorizationStatus.notDetermined
			case .denied:
				print("denied")
				status = CLAuthorizationStatus.denied
				//opens phone Settings so user can authorize permission
				//				guard let validSettingsURL: URL = URL(string: UIApplicationOpenSettingsURLString) else {return}
			//				UIApplication.shared.open(validSettingsURL, options: [:], completionHandler: nil)
			case .authorizedWhenInUse:
				print("authorizedWhenInUse")
				status = CLAuthorizationStatus.authorizedWhenInUse
			case .authorizedAlways:
				print("authorizedAlways")
				status = CLAuthorizationStatus.authorizedAlways
			default:
				break
			}
		}
			//Update UI to inform user
		else {
			print("location services NOT available")
			print("update UI to show location is not available")
		}
		return status
	}
}

//MARK: CLLocationManager Delegate
extension LocationService: CLLocationManagerDelegate {
	//Did update Location
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.last else { print("no locations"); return }
		print("didUpdateLocation: \(location)")
		UserPreference.manager.setLatitude(latitude: location.coordinate.latitude)
		UserPreference.manager.setLongitude(longitude: location.coordinate.longitude)
		// broadcast location change via custom delegate
		//		delegate?.locatonService(self, didUpdateLocation: location)
	}
	//Fail with error
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("did fail with error: \(error)")
	}
	//Did Change Authorization
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		print("did change Authorization: \(status)") //eg. denied

	}

}




