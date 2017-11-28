//
//  Business.swift
//  ContractorApp
//
//  Created by Zaizen Kaegyoshi on 10/25/17.
//  Copyright © 2017 Team5. All rights reserved.
//

import Foundation
import UIKit

class Business {
    
    var name: String
    var detail: String
    
    var ratings: Double = 0.0
    
    var reviews: [String] = []
    
    var link: String = ""
    
    var businessType: String
    
    var images: [UIImage] = []
    
    var tags: [String] = []
    
    init(name: String, detail: String, type: String, _ image: UIImage?) {
        self.name = name
        self.detail = detail
        self.businessType = type
        
        if let i = image {
            self.images.append(i)
        }
    }
    
}
