//  ResultsView.swift
//  HereAndThere
//  Created by C4Q on 1/16/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.

import UIKit

//Custom View for overall Layout of ResultsViewController (List)
class ResultsView: UIView {

	// MARK: - Create elements in View
	lazy var tableView: UITableView = {
		let tv = UITableView()
		tv.register(UITableViewCell.self, forCellReuseIdentifier: "ResultsCell")
		tv.backgroundColor = UIColor.lightGray
		return tv
	}()


	// MARK: - Setup elements in View
	override init(frame: CGRect) {
		super.init(frame: UIScreen.main.bounds) //set frame to the entire screen
		backgroundColor = .clear
		setUpViews()
	}
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	private func setUpViews() {
		addTableView()
	}


	// MARK: - Add elements & layout constraints to View
	private func addTableView() {
		addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
	}

}

