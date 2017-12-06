//
//  InboxTableCell.swift
//  ContractorApp
//
//  Created by Zaizen Kaegyoshi on 10/25/17.
//  Copyright © 2017 Team5. All rights reserved.
//

import UIKit

class InboxTableCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var businessNameLabel: UILabel!
//    @IBOutlet weak var projectNameLabel: UILabel!
//    @IBOutlet weak var typeNameLabel: UILabel!
    @IBOutlet weak var alertIndicator: UIView!
    @IBOutlet weak var imgView: UIImageView!
    
    func setCell(convo: ShowInbox.FetchInbox.ViewModel.DisplayableConversation) {
        self.businessNameLabel.text = convo.businessName
//        self.projectNameLabel.text = convo.projectName
//        self.typeNameLabel.text = convo.businessName
        self.alertIndicator.isHidden = true
        
//        self.imgView.image = img
    }
    
    
}
