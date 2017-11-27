//
//  ListBusinessesRouter.swift
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

@objc protocol ListBusinessesRoutingLogic
{
    func routeToShowBusiness(segue: UIStoryboardSegue)
}

protocol ListBusinessesDataPassing
{
    var dataStore: ListBusinessesDataStore? { get }
}

class ListBusinessesRouter: NSObject, ListBusinessesRoutingLogic, ListBusinessesDataPassing
{
    weak var viewController: ListBusinessesViewController?
    var dataStore: ListBusinessesDataStore?
    
    // MARK: Routing
    func routeToShowBusiness(segue: UIStoryboardSegue)
    {
        
        
        let destinationVC = segue.destination as! ShowBusinessesViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToShowProject(source: dataStore!, destination: &destinationDS)
    }
    func passDataToShowProject(source: ListBusinessesDataStore, destination: inout ShowBusinessesDataStore) {
        if viewController?.selectedCategory == "Search" {
            destination.business = source.results[viewController!.selectedIndex]
        } else { //if viewController?.selectedCategory == "Favorites" {
            destination.business = source.recommendations[viewController!.selectedIndex]
        }
//        let business: Business = source.businesses[viewController!.selectedCategory]![viewController!.selectedIndex]
        
        
    }
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}
    
    // MARK: Navigation
    
    //func navigateToSomewhere(source: ListBusinessesViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: ListBusinessesDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}