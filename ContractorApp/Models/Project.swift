//
//  Project.swift
//  ContractorApp
//
//  Created by Zaizen Kaegyoshi on 10/25/17.
//  Copyright © 2017 Team5. All rights reserved.
//

import Foundation
import UIKit

class Project {
    
    var name: String
    
    var images: [UIImage] = []
    
    var detail: String
    
    var jobType: String
    
//    var video
    
    init(name: String, detail: String, type: String) {
        self.name = name
        self.detail = detail
        self.jobType = type
    }
    
}
