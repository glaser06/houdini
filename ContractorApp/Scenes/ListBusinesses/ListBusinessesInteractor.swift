//
//  ListBusinessesInteractor.swift
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

protocol ListBusinessesBusinessLogic
{
    func fetchBusinesses()
    func fetchAll()
    func search(request: ListBusinesses.Search.Request)
    func fetchCategories()
}

protocol ListBusinessesDataStore
{
    var businesses: [String: [Business]] { get set}
    
    var categories: [String]! {get set}
    
    var recommendations: [Business]! {get set}
    
    var results: [Business]! {get set}
}

class ListBusinessesInteractor: ListBusinessesBusinessLogic, ListBusinessesDataStore
{
    var presenter: ListBusinessesPresentationLogic?
    var worker: ListBusinessesWorker = ListBusinessesWorker()
    var yelpWorker: YelpWorker = YelpWorker()
    //var name: String = ""
    var businesses: [String : [Business]] = [:]
    var categories: [String]!
    var recommendations: [Business]!
    var results: [Business]! = []
    
    
    // MARK: Do something
    init() {
        fetchBusinesses()
    }
    
    func fetchBusinesses() {
        self.worker.getBusinesses(completion: { (newData) in
            self.businesses = newData
//            self.presenter?.presentBusinesses(response: ListBusinesses.FetchBusinesses.Response(businesses: self.businesses))
        })
    }
    func fetchCategories() {
        let cats = ["AC and Heating", "Handyman",  "Electrician", "Home Cleaner", "Landscaper", "Roofing", "Mover", "Painter", "Plumber"]
        let imgs: [UIImage?] = [UIImage(named: "acrepair"),UIImage(named: "carpenter"),UIImage(named: "electrician"),UIImage(named: "cleaners"),UIImage(named: "landscaping"),UIImage(named: "roofing"),UIImage(named: "movers"),UIImage(named: "painter"),UIImage(named: "plumber2"), ]

        let zipped = Array(zip(cats, imgs))
        
        self.presenter?.presentCategories(response: ListBusinesses.FetchCategories.Response(categories: zipped))
    }
    func fetchAll() {
        self.fetchBusinesses()
        self.worker.getCategories { (categories) in
            self.worker.getRecommendations(completion: { (recs) in
                self.categories = categories.map({ (a) -> String in
                    a.0
                })
                self.recommendations = recs
                let a = ListBusinesses.FetchAll.Response(categories: categories, businesses: recs)
                self.presenter?.presentAll(response: a)
            })
        }
    }
    func search(request: ListBusinesses.Search.Request) {
        let query = request.query
        self.yelpWorker.search(params: YelpAPI.SearchParam(term: query, location: "", longitude: -79.95049, lattitude: 40.45659, radius: 20000, limit: -1, sort_by: "best_match", categories: "homeservices")) { (results) in
            
//            self.businesses["Nearby"] = results
            self.results = results
            let resp = ListBusinesses.Search.Response(businesses: results, query: query)
            self.presenter?.presentSearch(response: resp)
//            self.presenter?.presentBusinesses(response: Home.FetchBusinesses.Response(businesses: self.businesses))
//            for (index, each) in results.enumerated() {
//                self.homeWorker.fetchImage(imgURL: each.heroImageURL, completion: { (image) in
//                    self.businesses["Nearby"]![index].images.append(image)
//                    self.presenter?.updateImage(response: Home.UpdateImage.Response(image: image, section: "Nearby", index: index))
//                })
                
//            }
            
            
        }
//        yelpWorker.search(params: <#T##YelpAPI.SearchParam#>, completion: <#T##([Business]) -> Void#>)
        
//        let r = self.businesses.first!.value
//        self.results = r
        
        
    }
}
