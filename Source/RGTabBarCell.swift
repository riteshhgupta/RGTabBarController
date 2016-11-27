//
//  RGTabBarCell.swift
//  RGTabBarController
//
//  Created by Ritesh Gupta on 27/11/16.
//  Copyright © 2016 Ritesh Gupta. All rights reserved.
//

import UIKit

struct RGTabBarCellModel {
	let title: String
}

class RGTabBarCell: UICollectionViewCell {
	
	@IBOutlet var titleLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	func configure(withModel model: RGTabBarCellModel) {
		titleLabel.text = model.title
	}
	
}
