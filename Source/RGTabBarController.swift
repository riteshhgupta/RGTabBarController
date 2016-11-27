//
//  RGTabBarController.swift
//  RGTabBarController
//
//  Created by Ritesh Gupta on 26/11/16.
//  Copyright © 2016 Ritesh Gupta. All rights reserved.
//

import Foundation
import UIKit
import RGToolKit

protocol RGTabBarItem {
	var title: String { get set }
	var controller: UIViewController { get set }
}

class RGTabBarController: UIViewController {
	
	@IBOutlet var contentContainerView: ContainerView! {
		didSet {
			add(
				childVC: pageController,
				embedInContainerView: contentContainerView
			)
		}
	}
	
	let pageController: RGPageController
	
	init(items: [RGTabBarItem]) {
		pageController = RGPageController(items: items)
		super.init(nibName: nil, bundle: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
