//
//  BusinessHomeCell.swift
//  ContractorApp
//
//  Created by Zaizen Kaegyoshi on 11/28/17.
//  Copyright © 2017 Team5. All rights reserved.
//

import UIKit

class BusinessHomeCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    func setCell(name: String, img: UIImage, category: String, reviewCount: String) {
        self.nameLabel.text = "\(name)"
        self.img.image = img
        self.categoryLabel.text = category
        self.countLabel.text = reviewCount
    }

}
