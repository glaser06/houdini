//
//  QuoteMessageTableCell.swift
//  ContractorApp
//
//  Created by Zaizen Kaegyoshi on 11/29/17.
//  Copyright © 2017 Team5. All rights reserved.
//

import UIKit


let QuoteCellIdentifier: String = "QuoteCell"

class QuoteMessageTableCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var decide: ((Bool) -> Void)!
    
    func setCell(amount: String, desc: String, decision: @escaping (Bool) -> Void) {
        self.quoteLabel.text = amount
        self.descLabel.text = desc
        self.decide = decision
    }
    
    @IBAction func accept() {
        self.decide(true)
    }
    @IBAction func decline() {
        self.decide(false)
    }
    
}
