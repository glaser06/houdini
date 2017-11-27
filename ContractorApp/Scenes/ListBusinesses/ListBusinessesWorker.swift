//
//  ListBusinessesWorker.swift
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

class ListBusinessesWorker
{
    let service = BusinessTester()
    
    static let shared = ListBusinessesWorker()
    var businesses: [String: [Business]] = [:]
    
    init() {
        self.businesses = service.generate()
    }
    func getCategories(completion: @escaping ([(String, UIImage)]) -> Void) {
        completion([("Landscaping", #imageLiteral(resourceName: "landscaping")), ("Roofing", #imageLiteral(resourceName: "roofing")), ("Plumbing", #imageLiteral(resourceName: "plumber"))])
    }
    func getRecommendations(completion: @escaping ([Business]) -> Void) {
        completion(self.businesses.first!.value)
    }
    
    func getBusinesses(completion: @escaping ([String: [Business]]) -> Void) {
        self.businesses = service.generate()
        completion(self.businesses)
    }
}
