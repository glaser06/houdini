//
//  BusinessTester.swift
//  ContractorApp
//
//  Created by Zaizen Kaegyoshi on 10/25/17.
//  Copyright © 2017 Team5. All rights reserved.
//

import Foundation
import UIKit

class BusinessTester {
    
    
    static let imgs: [UIImage] = [#imageLiteral(resourceName: "plumber2"), #imageLiteral(resourceName: "movers"), #imageLiteral(resourceName: "painter")]
//    func generate() -> [String: [Business]] {
//        let categories = ["Plumber", "Mover", "AC Repair"]
//        let names = ["Bob's", "Jacobson", "Tom's", "Jack's", "Julia's", "Adam's", "Forbes"]
//        var dict: [String: [Business]] = [:]
//        for i in 0...12 {
//            let cate = categories[i % categories.count]
//            
//            if dict[cate] == nil {
//                dict[cate] = []
//            }
//            
//            let b = Business(name: "\(names[i/3 % 3]) \(cate)", id: "", phone: "", detail: "", type: cate, imgURL: "")
//            dict[cate]!.append(b)
//            
//        }
//        return dict
//    }
//    
//    func generateForCategories()  -> [String: (UIImage, [Business])] {
//        let categories = ["Home Cleaner", "Painter", "Plumber"]
//        let imgs = [#imageLiteral(resourceName: "cleaners"), #imageLiteral(resourceName: "painter2"), #imageLiteral(resourceName: "plumber2")]
//        let names = ["Bob's", "Jacobson", "Tom's", "Jack's", "Julia's", "Adam's", "Forbes"]
//        var dict: [String: (UIImage, [Business])] = [:]
//        for (index, cate) in categories.enumerated() {
//            for n in names {
//                
//                let b = Business(name: "\(n)", id: "", phone: "",detail: "", type: cate, imgURL: "")
//                if dict[cate] == nil {
//                    dict[cate] = (imgs[index], [])
//                }
//                
////                let b = Business(name: "\(names[i/3 % 3]) \(cate)", detail: "", type: cate, BusinessTester.imgs[i % 3])
//                dict[cate]!.1.append(b)
//            }
////            let cate = categories[i % categories.count]
//            
//            
//            
//        }
//        return dict
//    }
    
}
