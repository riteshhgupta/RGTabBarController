//
//  UIViewController+Extension.swift
//  RGToolKit
//
//  Created by Ritesh Gupta on 26/11/16.
//  Copyright © 2016 Ritesh Gupta. All rights reserved.
//

import Foundation
import UIKit

// functionality related to navigation buttons

extension UIViewController {
	
	func addRightNavbarItems(_ barButtonItems: [UIBarButtonItem]) {
		navigationItem.rightBarButtonItems = barButtonItems
	}
	func addLeftNavbarItems(_ barButtonItems: [UIBarButtonItem]) {
		navigationItem.leftBarButtonItems = barButtonItems
	}
	func addRightNavbarItem(_ barButtonItem: UIBarButtonItem) {
		addRightNavbarItems([barButtonItem])
	}
	func addLeftNavbarItem(_ barButtonItem: UIBarButtonItem) {
		addLeftNavbarItems([barButtonItem])
	}
}

// functionality related to Container View

extension UIViewController {
	
	func add(childVC: UIViewController, embedInContainerView containerView: ContainerView) {
		containerView.contentView = childVC.view
		
		childVC.willMove(toParentViewController: self)
		addChildViewController(childVC)
		childVC.didMove(toParentViewController: self)
	}
}
