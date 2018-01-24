//  DetailViewController.swift
//  HereAndThere
//  Created by C4Q on 1/16/18.
//  Copyright © 2018 HereAndThere. All rights reserved.

import UIKit

class DetailViewController: UIViewController {

    
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
        detailedView.tableView.register(ImageCell.self, forCellReuseIdentifier: "MapCell")
        detailedView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
		configureNavBar()
        configureDetailedVC()
//        detailedView.imageView.image = image
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
    private func configureDetailedVC() {
//        detailedView.placeLabel.text = venue.categories[0].name
//        detailedView.notesLabel.text = ""
    }

    @objc func addButtonTapped() {
        //let vc = CreateTipViewController(venue: venue, image: image)
        //navigationController?.pushViewController(vc, animated: true)
    }
    

}


extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 300
        default:
            return 45
        }
    }
}

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.imageV.image = image
        return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            cell.textLabel?.text = venue.categories[0].name
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            cell.textLabel?.text = "Tips Are Great"
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            cell.textLabel?.text = "default cell"
        return cell
    }
    
}
}
