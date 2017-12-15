//
//  PaymentInteractor.swift
//  ContractorApp
//
//  Created by Zaizen Kaegyoshi on 12/15/17.
//  Copyright (c) 2017 Team5. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol PaymentBusinessLogic
{
    func doSomething(request: Payment.Something.Request)
}

protocol PaymentDataStore
{
    //var name: String { get set }
}

class PaymentInteractor: PaymentBusinessLogic, PaymentDataStore
{
    var presenter: PaymentPresentationLogic?
    var worker: PaymentWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: Payment.Something.Request)
    {
        worker = PaymentWorker()
        worker?.doSomeWork()
        
        let response = Payment.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
