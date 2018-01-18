//  ResultsViewController.swift
//  HereAndThere
//  Created by C4Q on 1/16/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.

import UIKit

class ResultsViewController: UIViewController {

	//create instance of custom View
	var resultsView = ResultsView()

	//MARK: View Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.9, alpha: 1.0)
		view.addSubview(resultsView)  //add customView to access properties
		resultsView.tableView.dataSource = self
		configureNavBar()
	}

	//MARK: Navigation Bar
	private func configureNavBar(){
		navigationItem.title = "Results List"
	}

}



// MARK: TableView DataSource
extension ResultsViewController : UITableViewDataSource {
	//# of Sections
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	//# of Rows in Section
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10 //venues.count
	}
	//setup Cells
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		//		let venue = venues[indexPath.row]
//		var cell = tableView.dequeueReusableCell(withIdentifier: "ResultsCell", for: indexPath)
		let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "ResultsCell")
		cell.textLabel?.text = "Venue Name"
		cell.detailTextLabel?.text = "Category"
		cell.imageView?.image = nil
		cell.imageView?.image = #imageLiteral(resourceName: "placeholder-image")
		return cell
	}
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		//For deleting a row
		if editingStyle == UITableViewCellEditingStyle.delete {
			//			venues.remove(at: indexPath.row)
			tableView.reloadData()
		}
	}

}


//Table View Delegate Extension
extension ResultsViewController : UITableViewDelegate {
	func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		//	let venue = venues[indexPath.row]
		//	let detailVC = DetailViewController(venue: venues[indexPath.row] )
		let detailVC = DetailViewController()
		self.navigationController?.pushViewController(detailVC, animated: true)

//		let detailVC = DetailViewController()
//		detailVC.modalPresentationStyle = .overCurrentContext
//		detailVC.modalTransitionStyle = .crossDissolve
//		navigationController?.present(detailVC, animated: true, completion: nil)
	}

	//Setting cell height
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100.0
	}
}

extension ResultsViewController {
//	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//		if let detailVC = segue.destination as? DetailViewController {
////			detailVC.modalPresentationStyle = .overCurrentContext
////			detailVC.modalTransitionStyle = .crossDissolve
////			navigationController?.present(detailVC, animated: true, completion: nil)
//		}
//	}


}


