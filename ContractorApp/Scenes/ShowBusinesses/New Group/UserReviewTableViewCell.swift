//
//  UserReviewTableViewCell.swift
//  ContractorApp
//
//  Created by Zaizen Kaegyoshi on 11/8/17.
//  Copyright © 2017 Team5. All rights reserved.
//

import UIKit

class UserReviewTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    func setCell(name: String, desc: String, _ img: UIImage? = #imageLiteral(resourceName: "person1"), rating: String) {
        self.imgView.image = img ?? #imageLiteral(resourceName: "person1")
        self.nameLabel.text = name
        self.descLabel.text = desc
        self.ratingLabel.text = rating
    }
    
}
