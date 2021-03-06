//
//  ListBusinessesPresenter.swift
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

protocol ListBusinessesPresentationLogic
{
    func presentBusinesses(response: ListBusinesses.FetchBusinesses.Response)
    
    func presentAll(response: ListBusinesses.FetchAll.Response)
    
    func presentSearch(response: ListBusinesses.Search.Response)
    
    func presentCategories(response: ListBusinesses.FetchCategories.Response)
    
    func updateImage(response: ListBusinesses.UpdateImage.Response)
    
    
}

class ListBusinessesPresenter: ListBusinessesPresentationLogic
{
    weak var viewController: ListBusinessesDisplayLogic?
    
    // MARK: Do something
    
    func presentBusinesses(response: ListBusinesses.FetchBusinesses.Response) {
        var passingOn: [String: [ListBusinesses.FetchBusinesses.ViewModel.DisplayableBusiness]] = [:]
        for each in response.businesses {
            let category = each.key
            var anotherList: [ListBusinesses.FetchBusinesses.ViewModel.DisplayableBusiness] = []
            for business in each.value {
                let image: UIImage = business.images.count > 0 ? business.images[0] : #imageLiteral(resourceName: "placeholder")
                let displayed = ListBusinesses.FetchBusinesses.ViewModel.DisplayableBusiness(name: business.name, type: business.businessType[0].displayName, image: image, reviewCount: business.reviewCount)
                anotherList.append(displayed)
            }
            passingOn[category] = anotherList
            
            
        }
        self.viewController?.displayBusinesses(viewModel: ListBusinesses.FetchBusinesses.ViewModel(businesses: passingOn))
    }
    func presentAll(response: ListBusinesses.FetchAll.Response) {
        var final: [String : [(String, UIImage)]] = [:]
        final["History"] = response.categories
        final["Favorites"] = []
//        for each in response.categories {
//            final["History"] = response.categories
//        }
        for each in response.businesses {
            final["Favorites"]!.append((each.name, each.images[0]))
        }
        let vm = ListBusinesses.FetchAll.ViewModel(data: final)
        self.viewController?.displayAll(viewModel: vm)
    }
    func presentSearch(response: ListBusinesses.Search.Response) {
        var temp: [ListBusinesses.Search.ViewModel.DisplayableBusiness] = []
        var count = 0
        temp = response.businesses.map { (b) -> ListBusinesses.Search.ViewModel.DisplayableBusiness in
            count += 1
            return ListBusinesses.Search.ViewModel.DisplayableBusiness(name: b.name, image: UIImage(), rank: count)
        }
        let vm = ListBusinesses.Search.ViewModel(businesses: temp, query: response.query)
        self.viewController?.displaySearch(viewModel: vm)
    }
    func updateImage(response: ListBusinesses.UpdateImage.Response) {
        DispatchQueue.main.async {
            self.viewController?.updateImage(vm: ListBusinesses.UpdateImage.ViewModel(image: response.image, section: "0", index: response.index))
        }
    }
    func presentCategories(response: ListBusinesses.FetchCategories.Response) {
        self.viewController?.displayCategories(vm: ListBusinesses.FetchCategories.ViewModel(categories: response.categories))
    }
}
