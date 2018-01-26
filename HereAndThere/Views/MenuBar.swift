//
//  MenuBar.swift
//  HereAndThere
//
//  Created by C4Q on 1/25/18.
//  Copyright © 2018 HereAndThere. All rights reserved.
//

import Foundation
import UIKit


class MenuBar: UIView {

	// MARK: - Create elements in View
	lazy var button1: UIButton = {
		let button = UIButton()
		return button
	}()
	lazy var button2: UIButton = {
		let button = UIButton()
		return button
	}()
	lazy var button3: UIButton = {
		let button = UIButton()
		return button
	}()
	lazy var button4: UIButton = {
		let button = UIButton()
		return button
	}()
	lazy var button5: UIButton = {
		let button = UIButton()
		return button
	}()



	// MARK: - Setup elements in View
	override init(frame: CGRect){
		super.init(frame: UIScreen.main.bounds)
		setupViews()
	}
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	override func layoutSubviews() {
		super.layoutSubviews()
	}
	private func setupViews() {
		addButton1()
		addButton2()
		addButton3()
		addButton4()
		addButton5()
	}


	// MARK: - Add elements & layout constraints to View
	func addButton1(){
		addSubview(button1)
		button1.translatesAutoresizingMaskIntoConstraints = false
		button1.topAnchor.constraint(equalTo: topAnchor).isActive = true
		button1.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		button1.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		button1.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2).isActive = true
	}
	func addButton2(){
		addSubview(button2)
		button2.translatesAutoresizingMaskIntoConstraints = false
		button2.topAnchor.constraint(equalTo: topAnchor).isActive = true
		button2.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		button2.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		button2.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2).isActive = true
	}
	func addButton3(){
		addSubview(button1)
		button3.translatesAutoresizingMaskIntoConstraints = false
		button3.topAnchor.constraint(equalTo: topAnchor).isActive = true
		button3.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		button3.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		button3.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2).isActive = true
	}
	func addButton4(){
		addSubview(button1)
		button4.translatesAutoresizingMaskIntoConstraints = false
		button4.topAnchor.constraint(equalTo: topAnchor).isActive = true
		button4.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		button4.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		button4.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2).isActive = true
	}
	func addButton5(){
		addSubview(button1)
		button5.translatesAutoresizingMaskIntoConstraints = false
		button5.topAnchor.constraint(equalTo: topAnchor).isActive = true
		button5.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		button5.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		button5.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2).isActive = true
	}

}




