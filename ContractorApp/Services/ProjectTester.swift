//
//  ProjectTester.swift
//  ContractorApp
//
//  Created by Zaizen Kaegyoshi on 10/25/17.
//  Copyright © 2017 Team5. All rights reserved.
//

import Foundation
import UIKit

class ProjectTester {
    
    func generate() -> [Project] {
        
        let names = ["Toilet broke", "Moving Apartments", "Bedroom Paint Job"]
        var projects: [Project] = []
        for name in names{
            let project = Project(name: name, detail: "something", type: "Plumber")
            let images: [UIImage] = [#imageLiteral(resourceName: "plumber2"),#imageLiteral(resourceName: "movers"),#imageLiteral(resourceName: "painter")]
            project.images = images
            projects.append(project)
            
        }
        
        return projects
    }
    
}
