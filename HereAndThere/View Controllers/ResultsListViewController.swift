//  ResultsViewController.swift
//  HereAndThere
//  Created by C4Q on 1/16/18.
//  Copyright © 2018 HereAndThere. All rights reserved.

import UIKit

class ResultsListViewController: UIViewController {

	//create an instance of my view
	var resultsView = ResultsListView()
    
	var venues: [Venue]!
	var photoForVenue: [String: UIImage] = [:] //venueID: UIImage

	init(venues: [Venue], photoForVenue: [String:UIImage]) {
		super.init(nibName: nil, bundle: nil)
		self.venues = venues
		self.photoForVenue = photoForVenue
	}
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad(){
        view.backgroundColor = .cyan
        view.addSubview(resultsView)
        resultsView.tableView.register(ResultsListTableViewCell.self, forCellReuseIdentifier: "ResultsTableViewCell")
        resultsView.tableView.delegate = self
        resultsView.tableView.dataSource = self
        setupNavigationBar()
    }
    
    //set up navigation bar
    fileprivate func setupNavigationBar() {
        navigationItem.title = "Results List"
        navigationItem.largeTitleDisplayMode = .always
    }
}

extension ResultsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("Selected Row \(indexPath.row)")
        let venue = venues[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)
        let detailVC = ResultsListDetailViewController(venue: venue, image: (cell?.imageView?.image)!)
        detailVC.modalTransitionStyle = .crossDissolve
        detailVC.modalPresentationStyle = .overCurrentContext
        navigationController?.pushViewController(detailVC, animated: true)
        //present(detailVC, animated: true, completion: nil)
    }
    
}

extension ResultsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let venue = venues[indexPath.row]
//        var cell = resultsView.tableView.dequeueReusableCell(withIdentifier: "ResultsTableViewCell", for: indexPath)
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle,
                               reuseIdentifier: "ResultsTableViewCell")
			cell.textLabel?.text = venue.name
			cell.detailTextLabel?.text = venue.categories.first?.name ?? "N/A"
			cell.imageView?.image = nil
			cell.imageView?.image = photoForVenue[venue.id]
			return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0//Choose your custom row height
    }
}

