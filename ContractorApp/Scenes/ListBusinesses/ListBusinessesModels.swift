//
//  ListBusinessesModels.swift
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

enum ListBusinesses
{
    // MARK: Use cases
    
    enum FetchBusinesses
    {
        struct Request
        {
        }
        struct Response
        {
            var businesses: [String: [Business]]
        }
        struct ViewModel
        {
            struct DisplayableBusiness {
                var name: String
                var type: String
                var image: UIImage
                var reviewCount: Int
            }
            var businesses: [String: [DisplayableBusiness]]
        }
    }
    enum FetchAll {
        struct Request
        {
            
        }
        struct Response
        {
            var categories: [(String, UIImage)]
            var businesses: [Business]
        }
        struct ViewModel
        {
            struct DisplayableBusiness {
                var name: String
//                var type: String
                var image: UIImage
//                var reviewCount: Int
            }
            var data: [String: [(String, UIImage)]]
        }
    }
    enum Search {
        struct Request
        {
            var query: String
        }
        struct Response
        {
            var businesses: [Business]
            var query: String
        }
        struct ViewModel
        {
            struct DisplayableBusiness {
                var name: String
//                var type: String
                var image: UIImage
                var rank: Int
//                var reviewCount: Int
            }
            
            var businesses: [DisplayableBusiness]
            var query: String
        }
    }
}
