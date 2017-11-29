//
//  BusinessCollectionCell.swift
//  ContractorApp
//
//  Created by Zaizen Kaegyoshi on 10/25/17.
//  Copyright © 2017 Team5. All rights reserved.
//

import UIKit

class BusinessCollectionCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var imageView: UIImageView!
//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
//    @IBOutlet var stars: [UIImageView]!
    
    func setCell(name: String, img: UIImage?) {
        self.imageView.image = img ?? #imageLiteral(resourceName: "placeholder")
        self.typeLabel.text = name
//        self.reviewLabel.text = "\(business.reviewCount)"
        
    }

}
