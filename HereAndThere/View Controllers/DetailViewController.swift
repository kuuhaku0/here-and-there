//  DetailViewController.swift
//  HereAndThere
//  Created by C4Q on 1/16/18.
//  Copyright © 2018 HereAndThere. All rights reserved.

import UIKit
import MapKit

class DetailViewController: UIViewController {

	// MARK: View Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.9, alpha: 1.0)
		configureNavBar()
	}

	//MARK: Property
	private var venue: Venue!

	//Custom Initializer
	init(venue: Venue) {
		super.init(nibName: nil, bundle: nil)
		self.venue = venue
	}
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK :
	private func configureNavBar() {
		navigationItem.title = venue.name
		navigationItem.largeTitleDisplayMode = .always
	}

    var detailedView = DetailedView()
    private var venue: Venue!
    private var image: UIImage!
    
    lazy var addButton: UIBarButtonItem = {
        let addButton = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: #selector(addButtonTapped))
        addButton.image = #imageLiteral(resourceName: "plus")
        return addButton
    }()
    
	// MARK: View Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
        view.addSubview(detailedView)
        view.backgroundColor = .white
        detailedView.tableView.delegate = self
        detailedView.tableView.dataSource = self
        detailedView.tableView.register(ImageCell.self, forCellReuseIdentifier: "ImageCell")
        detailedView.tableView.register(MapCell.self, forCellReuseIdentifier: "MapCell")
        detailedView.tableView.register(ButtonCell.self, forCellReuseIdentifier: "ButtonCell")
        detailedView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
		configureNavBar()
	}

    //Custom Initializer
    init(venue: Venue, image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.venue = venue
        self.image = image
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK :
    private func configureNavBar() {
        
        navigationItem.title = venue.name
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = addButton
        
    }


    @objc func addButtonTapped() {
        let vc = CreateTipViewController(venue: venue, image: image)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}


extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 300
        case 3:
            return 150
        default:
            return 30
        }
    }
}

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.imageV.image = image
        cell.selectionStyle = .none
        return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            cell.textLabel?.text = venue.categories[0].name
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            cell.textLabel?.text = "Tips Are Great"
            cell.textLabel?.textColor = .lightGray
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MapCell", for: indexPath) as! MapCell
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: venue.location.lat, longitude: venue.location.lng)
            cell.mapV.addAnnotation(annotation)
            cell.mapV.showAnnotations(cell.mapV.annotations, animated: true)
            cell.mapV.centerCoordinate = CLLocationCoordinate2D(latitude: venue.location.lat, longitude: venue.location.lng)
            cell.mapV.isScrollEnabled = false
            cell.selectionStyle = .none
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            if venue != nil {
                cell.textLabel?.text = "Address: \(venue.location.address!), \(venue.location.city!), \(venue.location.country)"
            }
            cell.selectionStyle = .none
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell", for: indexPath) as! ButtonCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            cell.textLabel?.text = "default cell"
            cell.selectionStyle = .none
        return cell
    }
    
}
}
