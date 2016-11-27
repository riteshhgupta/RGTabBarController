//
//  RGPageController.swift
//  RGTabBarController
//
//  Created by Ritesh Gupta on 27/11/16.
//  Copyright © 2016 Ritesh Gupta. All rights reserved.
//

import UIKit
import RGToolKit

typealias IndexClosure = (Int) -> Void

class RGPageController: UIPageViewController {
	
	let items: [RGTabBarItem]
	var scrollView: UIScrollView?
	var currentIndex: Int = 0 {
		didSet {
			didChangePage?(currentIndex)
		}
	}
	var potentialNextIndex: Int = 0
	
	var didChangePage: IndexClosure?
	
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
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		scrollView = view.subviews.filter { $0 is UIScrollView }.first as? UIScrollView
		scrollView?.delegate = self
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension RGPageController: UIScrollViewDelegate {
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
	}
}

extension RGPageController: UIPageViewControllerDelegate {
	
	func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
		currentIndex += pageViewController.indexFactor
	}
}

extension RGPageController: UIPageViewControllerDataSource {
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		return items.map { $0.controller }.after(viewController)
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		return items.map { $0.controller }.before(viewController)
	}
}

extension UIPageViewController {
	
	var indexFactor: Int {
		let sv = view.subviews.filter { $0 is UIScrollView }.first as? UIScrollView
		guard let scrollView = sv else { return 0 }
		if scrollView.contentOffset.x == 0 { return -1 }
		else if scrollView.contentOffset.x == 750 { return 1 }
		return 0
	}
}
