//
//  RGPageController.swift
//  RGTabBarController
//
//  Created by Ritesh Gupta on 27/11/16.
//  Copyright © 2016 Ritesh Gupta. All rights reserved.
//

import UIKit
import RGToolKit

typealias Closure<T> = (T) -> Void

class RGPageController: UIPageViewController {
	
	let controllers: [UIViewController]
	var currentPage: Int = 0 {
		didSet {
			didChangePage?(currentPage)
		}
	}
	
	var didChangePage: Closure<Int>?
	var didChangePageContentOffset: Closure<CGFloat>?
	var previousContentOffset: CGFloat = 375.0
	var shouldObserveForContentOffsetChange = true
	
	init(controllers: [UIViewController]) {
		self.controllers = controllers
		super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
		guard !controllers.isEmpty else { return }
		delegate = self
		dataSource = self
		
		show(viewController: controllers[0])
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		scrollView?.delegate = self
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func move(toPage page: Int) {
		guard currentPage != page else { return }
		shouldObserveForContentOffsetChange = false
		currentPage = page
		let dr = direction(forNextPage: page)
		show(viewController: controllers[page], inDirection: dr)
	}
	
	func direction(forNextPage page: Int) -> UIPageViewControllerNavigationDirection {
		return (page > currentPage) ? .forward : .reverse
	}
}

extension RGPageController: UIScrollViewDelegate {
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let currentOffset = scrollView.contentOffset.x
		previousContentOffset = currentOffset
		
		if shouldObserveForContentOffsetChange {
			let delta = (currentOffset - previousContentOffset)/CGFloat(controllers.count)
			didChangePageContentOffset?(delta)
		}
	}
	
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		shouldObserveForContentOffsetChange = true
	}
	
	func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
		shouldObserveForContentOffsetChange = true
	}
}

extension RGPageController: UIPageViewControllerDelegate {
	
	func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
		currentPage += pageViewController.pageFactor
		shouldObserveForContentOffsetChange = false
	}
}

extension RGPageController: UIPageViewControllerDataSource {
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		return controllers.after(viewController)
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		return controllers.before(viewController)
	}
}

extension UIPageViewController {
	
	var pageFactor: Int {
		guard let scrollView = scrollView else { return 0 }
		if scrollView.contentOffset.x < 375.0 { return -1 }
		else if scrollView.contentOffset.x > 375.0 { return 1 }
		return 0
	}
	func show(viewController: UIViewController, inDirection direction: UIPageViewControllerNavigationDirection = .forward) {
		setViewControllers([viewController], direction: direction, animated: true, completion: nil)
	}
	var scrollView: UIScrollView? {
		return view.subviews.filter { $0 is UIScrollView }.first as? UIScrollView
	}
}












