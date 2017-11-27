//
//  ImageMessageTableViewCell.swift
//  ContractorApp
//
//  Created by Zaizen Kaegyoshi on 11/15/17.
//  Copyright © 2017 Team5. All rights reserved.
//

import UIKit

class ImageMessageTableViewCell: UITableViewCell {
    
    static let identifier: String = "ImageMessageTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var imgView: UIImageView!
    
    func setCell(img: UIImage) {
        self.imgView.image = img
    }
    
}
