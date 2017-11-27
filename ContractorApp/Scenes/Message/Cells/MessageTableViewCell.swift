//
//  MessageTableViewCell.swift
//  ContractorApp
//
//  Created by Zaizen Kaegyoshi on 11/8/17.
//  Copyright © 2017 Team5. All rights reserved.
//

import UIKit

let MessageCellIdentifier: String = "MessageCell"

class MessageTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var messageView: UITextView!
    
    func setCell(message: String) {
        self.messageView.text = message.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
}
