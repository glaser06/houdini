//
//  TallContractorCollectionCell.swift
//  ContractorApp
//
//  Created by Zaizen Kaegyoshi on 11/8/17.
//  Copyright © 2017 Team5. All rights reserved.
//

import UIKit

class TallContractorCollectionCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    
    func setCell(name: String, count: Int, img: UIImage) {
        self.nameLabel.text = name.capitalized
        self.countLabel.text = "\(count) pros near you"
        self.image.image = img
    }

}
