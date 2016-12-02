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
	
	@IBOutlet var collectionView: UICollectionView! {
		didSet {
			collectionView.delegate = self
			collectionView.dataSource = self
			collectionView.register(
				RGTabBarCell.nib,
				forCellWithReuseIdentifier: RGTabBarCell.className
			)
		}
	}
	
	@IBOutlet var sliderWidthConstraint: NSLayoutConstraint! {
		didSet {
			let width = UIScreen.main.bounds.width
			sliderWidthConstraint.constant = width/CGFloat(items.count)
		}
	}
	@IBOutlet var sliderLeftConstraint: NSLayoutConstraint!
	
	let pageController: RGPageController
	
	let items: [RGTabBarItem]
	
	var shouldMoveSlider = true
	
	init(items: [RGTabBarItem]) {
		self.items = items
		self.pageController = RGPageController(controllers: items.map { $0.controller })
		super.init(nibName: nil, bundle: nil)
		
		pageController.didChangePage = { page in
			self.moveSlider(toPage: page)
		}
		
		pageController.didChangePageContentOffset = { pageFactor in
			var newValue = self.sliderLeftConstraint.constant
			newValue += pageFactor
			if self.shouldMoveSlider {
				self.sliderLeftConstraint.constant = newValue
				self.view.layoutIfNeeded()
			} else {
				self.shouldMoveSlider = true
			}
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func animateSlider(toValue value: CGFloat) {
		sliderLeftConstraint.constant = value
		UIView.animate(withDuration: 0.25, animations: {
			self.view.layoutIfNeeded()
		})
	}
	
	func moveSlider(toPage page: Int) {
		let newValue = CGFloat(page)*sliderWidthConstraint.constant
		animateSlider(toValue: newValue)
	}
}

extension RGTabBarController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let cellWidth = UIScreen.main.bounds.width/CGFloat(items.count)
		let cellHeight = collectionView.frame.height
		return CGSize(width: cellWidth, height: cellHeight)
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let page = indexPath.row
		pageController.move(toPage: page)
		shouldMoveSlider = false
	}
}

extension RGTabBarController: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return items.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell: RGTabBarCell = collectionView.dequeueReusableGenericCell(
			withReuseIdentifier: RGTabBarCell.className,
			for: indexPath
		)
		cell.configure(
			withModel: RGTabBarCellModel(title: items[indexPath.row].title)
		)
		return cell
	}
}
