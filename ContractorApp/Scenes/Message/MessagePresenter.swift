//
//  MessagePresenter.swift
//  ContractorApp
//
//  Created by Zaizen Kaegyoshi on 10/25/17.
//  Copyright (c) 2017 Team5. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MessagePresentationLogic
{
    func presentMessages(response: Message.FetchMessages.Response)
    func updateQuote(response: Message.UpdateQuote.Response)
    func updateSchedule(response: Message.UpdateSchedule.Response)
}

class MessagePresenter: MessagePresentationLogic
{
    weak var viewController: MessageDisplayLogic?
    
    // MARK: Do something
    
    func presentMessages(response: Message.FetchMessages.Response) {
        let msgs = response.messages
//        let msgs = response.messages.filter { (m) -> Bool in
//            m.sender == "contractor" || m.sender == response.
//
//
//        }
        self.viewController?.displayMessages(vm: Message.FetchMessages.ViewModel(userName: response.userName, businessName: response.businessName, projectName: response.projectName, messages: msgs))
    }
    func updateQuote(response: Message.UpdateQuote.Response) {
        let price = response.quotePrice
        if let p = price {
            self.viewController?.displayQuote(vm: Message.UpdateQuote.ViewModel(quotePrice: "$\(p)"))
        } else {
            self.viewController?.displayQuote(vm: Message.UpdateQuote.ViewModel(quotePrice: "No price quoted"))
        }
        
    }
    func updateSchedule(response: Message.UpdateSchedule.Response) {
        let price = response.schedule
        if let time = price {
            let calendar = Calendar.current
            let day = calendar.component(.day, from: time)
            let month = calendar.component(.month, from: time)
            let hour = calendar.component(.hour, from: time)
            let minute = calendar.component(.minute, from: time)
            let sched = "\(month) / \(day) at \(hour) : \(minute) "
            viewController?.displaySchedule(vm: Message.UpdateSchedule.ViewModel(schedule: sched))
        } else {
            
        }
        
    }
}
