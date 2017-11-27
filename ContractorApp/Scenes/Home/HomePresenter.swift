//
//  HomePresenter.swift
//  ContractorApp
//
//  Created by Zaizen Kaegyoshi on 11/8/17.
//  Copyright (c) 2017 Team5. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol HomePresentationLogic
{
    func presentCategories(response: Home.FetchCategories.Response)
}

class HomePresenter: HomePresentationLogic
{
    weak var viewController: HomeDisplayLogic?
    
    // MARK: Do something
    
    func presentCategories(response: Home.FetchCategories.Response) {
        self.viewController?.displayCategories(viewModel: Home.FetchCategories.ViewModel(data: response.data))
    }
    
}
