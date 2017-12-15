//
//  ScheduleTableViewCell.swift
//  ContractorApp2
//
//  Created by Zaizen Kaegyoshi on 12/6/17.
//  Copyright © 2017 Team5. All rights reserved.
//

import UIKit


let ScheduleCellIdentifier = "ScheduleCell"

class ScheduleTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var times: [Date] = []
    var decide: ((String, Int) -> Void)!
    
    func setCell(msg: Message.ScheduleMessage) {
        let times: [Date] = msg.availabilities.map { (d) -> Date in
            return Date(timeIntervalSince1970: d)
        }
        let duration = msg.duration
        let title = msg.title
        self.titleLabel.text = title
        let calendar = Calendar.current
        var labels = [dateLabel1,dateLabel2,dateLabel3]
        for (n,time) in times.enumerated() {
            let day = calendar.component(.day, from: time)
            let month = calendar.component(.month, from: time)
            let hour = calendar.component(.hour, from: time)
            let minute = calendar.component(.minute, from: time)
            labels[n]!.setTitle("\(month) / \(day) at \(hour) : \(minute) ", for: .normal)
        }
        
        self.durationLabel.text = "\(duration) minutes"
        //        self.dateLabel1.setTitle(times[0]., for: <#T##UIControlState#>)
    }
    
    @IBOutlet weak var dateLabel1: UIButton!
    @IBOutlet weak var dateLabel2: UIButton!
    @IBOutlet weak var dateLabel3: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    
    
}
