//
//  RGPageController.swift
//  RGTabBarController
//
//  Created by Ritesh Gupta on 27/11/16.
//  Copyright © 2016 Ritesh Gupta. All rights reserved.
//

import UIKit

class RGPageController: UIPageViewController {
	
	let items: [RGTabBarItem]
	
	init(items: [RGTabBarItem]) {
		self.items = items
		super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
		guard !items.isEmpty else { return }
		delegate = self
		dataSource = self
		
		setViewControllers(
			[items[0].controller],
			direction: .forward,
			animated: true,
			completion: nil
		)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension RGPageController: UIPageViewControllerDelegate {}

extension RGPageController: UIPageViewControllerDataSource {
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		return items.map { $0.controller }.after(viewController)
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		return items.map { $0.controller }.before(viewController)
	}
}
