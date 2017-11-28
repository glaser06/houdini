//
//  HomeModels.swift
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

enum Home
{
    // MARK: Use cases
    
    enum FetchCategories
    {
        struct Request
        {
        }
        struct Response
        {
            var data: [(tag: String, count: Int, img: UIImage)]
        }
        struct ViewModel
        {
            var data: [(tag: String, count: Int, img: UIImage)]
        }
    }
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
}
