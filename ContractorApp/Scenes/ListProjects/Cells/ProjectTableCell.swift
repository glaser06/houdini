//
//  ProjectTableCell.swift
//  ContractorApp
//
//  Created by Zaizen Kaegyoshi on 10/25/17.
//  Copyright © 2017 Team5. All rights reserved.
//

import UIKit

class ProjectTableCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var imageViews: [UIImageView]!
    @IBOutlet weak var typeLabel: UILabel!
    
    func setCell(project: Project) {
        self.nameLabel.text = project.name
        zip(self.imageViews, project.images).map { (imgView, img) -> Void in
            imgView.image = img
        }
        self.typeLabel.text = project.jobType
        
    }
    
}
