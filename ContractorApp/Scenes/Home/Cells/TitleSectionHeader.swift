//
//  TitleSectionHeader.swift
//  ContractorApp
//
//  Created by Zaizen Kaegyoshi on 11/27/17.
//  Copyright © 2017 Team5. All rights reserved.
//

import UIKit

class TitleSectionHeader: UICollectionReusableView {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func setCell(title: String) {
        self.titleLabel.text = title
    }
    
}
