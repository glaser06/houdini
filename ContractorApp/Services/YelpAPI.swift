//
//  YelpAPI.swift
//  ContractorApp
//
//  Created by Zaizen Kaegyoshi on 11/28/17.
//  Copyright © 2017 Team5. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class YelpAPI {
    static let cacher = YelpAPI()
    
    var accessToken = ""
    
    var tokenWaiter = DispatchGroup()
    
    struct SearchParam {
        var term: String
        var location: String
        var longitude: Double
        var lattitude: Double
        var radius: Int
        var limit: Int
        var sort_by: String
        var categories: String
    }
    
    static let url = "https://api.yelp.com"
    
    static func search(searchParams: SearchParam,  completion: @escaping ((JSON) -> Void)) {
        let reqURL = "\(url)/v3/businesses/search"
        
        var params: Parameters = [
            "term": searchParams.term,
            "location": searchParams.location,
            "longitude": searchParams.longitude,
            "latitude": searchParams.lattitude,
            "radius": searchParams.radius,
            
            "sort_by": searchParams.sort_by,
            "categories": searchParams.categories,
            ]
        if searchParams.limit >= 0 {
            params["limit"] = searchParams.limit
        }
        
        getRequest(reqURL: reqURL, params: params, completion: completion)
        
        
    }
    
    static func businessInfo(for id: String, completion:  @escaping ((JSON) -> Void)) {
        let reqURL = "\(url)/v3/businesses/\(id)"
        getRequest(reqURL: reqURL, params: nil, completion: completion)
    }
    static func reviews(for id: String, completion: @escaping ((JSON) -> Void)) {
        let reqURL = "\(url)/v3/businesses/\(id)/reviews"
        getRequest(reqURL: reqURL, params: nil, completion: completion)
    }
    
    static func getRequest(reqURL: String, params: Parameters?,  completion: @escaping ((JSON) -> Void)) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(cacher.accessToken)",
            
        ]
        print(cacher.accessToken)
        if let p = params {
            Alamofire.request(reqURL, method: .get, parameters: p, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
                if let val = response.result.value {
                    let json = JSON(val)
//                    print(json)
//                    print(response.request)
                    completion(json)
                }
            }
        } else {
            Alamofire.request(reqURL, method: .get, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
                if let val = response.result.value {
                    let json = JSON(val)
//                    print(json)
                    completion(json)
                }
            }
        }
        
    }
    
//    static func unwrap(response: DataResponse<Any>, completion: @escaping ((JSON) -> Void)) {
//        if let val = response.result.value {
//            let json = JSON(val)
//            print(json)
//            completion(json)
//        }
//    }
    
    
    
    static func getToken() {
        let id = "MnUy2Jy-T6ZUZNVex5ZW9g"
        let secret = "oUgCiaVFAArtFrivejQtRnrCMgpDPoz38SkgwgdvpfhcrjGPieZiWSTbA7TBvXyy"
        let params: Parameters = [
            "grant_type": "1.3",
            "client_id": id,
            "client_secret": secret
        ]
        let reqURL = "\(url)/oauth2/token"
        cacher.tokenWaiter.enter()
        Alamofire.request(reqURL, method: .post, parameters: params, encoding: URLEncoding.default).responseJSON { (response) in
            if let val = response.result.value {
                let json = JSON(val)
                cacher.cache(token: json["access_token"].stringValue)
                
                print(json)
                cacher.tokenWaiter.leave()
                //                completion(json)
            }
        }
    }
    func cache(token: String) {
        self.accessToken = token
        UserDefaults.standard.set(token, forKey: "YelpToken")
    }
    func unpack() {
        if let token = UserDefaults.standard.string(forKey: "YelpToken") {
            self.accessToken = token
        } else {
            self.accessToken = ""
        }
    }
}
