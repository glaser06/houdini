//
//  ReviewTableViewCell.swift
//  ContractorApp
//
//  Created by Zaizen Kaegyoshi on 11/8/17.
//  Copyright © 2017 Team5. All rights reserved.
//

import UIKit


class ReviewTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    func setCell(name: String, img: UIImage, rank: Int) {
        self.nameLabel.text = "\(rank). \(name)"
        self.img.image = img
    }
    
    
}
