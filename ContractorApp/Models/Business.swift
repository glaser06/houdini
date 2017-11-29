//
//  Business.swift
//  ContractorApp
//
//  Created by Zaizen Kaegyoshi on 10/25/17.
//  Copyright © 2017 Team5. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

struct Address {
    var street: String
    var city: String
    var state: String
    var zipcode: String
    var country: String
    
    var street2: String?
    var street3: String?
    
}
struct Review {
    var detail: String
    var url: String
    
    var rating: String
    var username: String
    var userImgURL: String
    var timeCreated: String
}
struct Category {
    var alias: String
    var displayName: String
}

class Business {
    
    var id: String
    var name: String
    var detail: String = ""
    
    var phone: String
    var displayPhone: String = ""
    
    var location: Address!
    var coordinates: CLLocationCoordinate2D!
    var displayAddress: String = ""
    
    
    
    
    var rating: Double = 0.0
    var reviews: [Review] = []
    var reviewCount: Int = 0
    
    var yelpURL: String = ""
    
    var businessType: [Category] = []
    
    var images: [UIImage] = []
    
    var tags: [String] = []
    
    var heroImageURL: String = ""
    var imageURLs: [String] = []
    
    init(name: String, id: String, phone: String, detail: String, imgURL: String) {
        self.name = name
        self.detail = detail
//        self.businessType = [Category(alias: type, displayName: type)]
        self.id = id
        self.phone = phone
        
        self.heroImageURL = imgURL
//        if let i = image {
//            self.images.append(i)
//        }
    }
    
    
}
