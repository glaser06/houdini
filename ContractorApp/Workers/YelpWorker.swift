//
//  YelpWorker.swift
//  ContractorApp
//
//  Created by Zaizen Kaegyoshi on 11/28/17.
//  Copyright (c) 2017 Team5. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import SwiftyJSON
import CoreLocation

class YelpWorker
{
    func getBusiness(id: String, completion: @escaping (Business) -> Void) {
        YelpAPI.businessInfo(for: id) { (b) in
            let categories: [Category] = b["categories"].arrayValue.map({ (c) -> Category in
                Category(alias: c["alias"].stringValue, displayName: c["title"].stringValue)
            })
            let business = Business(name: b["name"].stringValue, id: b["id"].stringValue, phone: b["phone"].stringValue, detail: "", imgURL: b["image_url"].stringValue)
            business.businessType = categories
            business.location = self.parseLocation(json: b["location"])
            business.reviewCount = b["review_count"].intValue
            business.rating = b["rating"].doubleValue
            business.yelpURL = b["url"].stringValue
            business.coordinates = self.parseCoordinates(json: b["coordinates"])
            business.displayPhone = b["display_phone"].stringValue
            business.displayAddress = b["location"]["display_address"].stringValue
            business.imageURLs = b["photos"].arrayValue.map({ (url) -> String in
                url.stringValue
            })
            completion(business)
        }
    }
    func getBusiness(business: Business, completion: @escaping (Business) -> Void) {
        YelpAPI.businessInfo(for: business.id) { (json) in
            business.displayPhone = json["display_phone"].stringValue
            business.displayAddress = json["location"]["display_address"].stringValue
            business.imageURLs = json["photos"].arrayValue.map({ (url) -> String in
                url.stringValue
            })
            completion(business)
            
        }
    }
    func search(params: YelpAPI.SearchParam, completion: @escaping ([Business]) -> Void) {
        
        YelpAPI.search(searchParams: params) { (json) in
            let businesses = json["businesses"].arrayValue
            var processed: [Business] = []
            for b in businesses {
                let categories: [Category] = b["categories"].arrayValue.map({ (c) -> Category in
                    Category(alias: c["alias"].stringValue, displayName: c["title"].stringValue)
                })
                let business = Business(name: b["name"].stringValue, id: b["id"].stringValue, phone: b["phone"].stringValue, detail: "", imgURL: b["image_url"].stringValue)
                business.businessType = categories
                business.location = self.parseLocation(json: b["location"])
                business.reviewCount = b["review_count"].intValue
                business.rating = b["rating"].doubleValue
                business.yelpURL = b["url"].stringValue
                business.coordinates = self.parseCoordinates(json: b["coordinates"])
                
                processed.append(business)
            }
            completion(processed)
            
        }
    }
    func parseLocation(json: JSON) -> Address {
        let addr = json["address1"].stringValue
        let city = json["city"].stringValue
        let state = json["state"].stringValue
        let zip = json["zip_code"].stringValue
        let country = json["country"].stringValue
        return Address(street: addr, city: city, state: state, zipcode: zip, country: country, street2: nil, street3: nil)
    }
    func parseCoordinates(json: JSON) -> CLLocationCoordinate2D {
        let lat = json["latitude"].doubleValue
        let long = json["longitude"].doubleValue
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
//        return coords
    }
}
