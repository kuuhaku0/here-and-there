//  Annotation.swift
//  HereAndThere
//  Created by C4Q on 1/18/18.
//  Copyright © 2018 HereAndThere. All rights reserved.

import UIKit
import MapKit

//custom class for storing Annotations for the Map on SearchViewController
class venueLocation: NSObject, MKAnnotation {
	var coordinate: CLLocationCoordinate2D
	var title: String?
	var subtitle: String?
	//var image: UIImage?

	init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String?) {
		self.coordinate = coordinate
		self.title = title
		self.subtitle = subtitle
	}
}

class venueLocationView: MKAnnotationView {
	// Required for MKAnnotationView
	required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }

	override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
		super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
		guard let locationPin = self.annotation else { return }
		//TO-DO
	}
}
