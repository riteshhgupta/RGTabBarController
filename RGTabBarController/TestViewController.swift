//
//  TestViewController.swift
//  RGTabBarController
//
//  Created by Ritesh Gupta on 27/11/16.
//  Copyright © 2016 Ritesh Gupta. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
	
	@IBOutlet var titleLabel: UILabel! {
		didSet {
			titleLabel.text = self.vcTitle
		}
	}
	
	let vcTitle: String
	
	init(title: String) {
		self.vcTitle = title
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
