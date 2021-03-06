//
//  AddProjectRouter.swift
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

@objc protocol AddProjectRoutingLogic
{
    func routeToAddMultimedia(segue: UIStoryboardSegue?)
}

protocol AddProjectDataPassing
{
  var dataStore: AddProjectDataStore? { get }
}

class AddProjectRouter: NSObject, AddProjectRoutingLogic, AddProjectDataPassing
{
  weak var viewController: AddProjectViewController?
  var dataStore: AddProjectDataStore?
  
  // MARK: Routing
    
    func routeToAddMultimedia(segue: UIStoryboardSegue?) {
        let destinationVC = segue!.destination as! AddMultimediaViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToAddMultimedia(source: dataStore!, destination: &destinationDS)
        
        
    }
    func passDataToAddMultimedia(source: AddProjectDataStore, destination: inout AddMultimediaDataStore) {
        destination.imageIndex = (viewController?.multimediaCollectionView.indexPathsForSelectedItems?.first?.item) ?? 0
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
  
  //func navigateToSomewhere(source: AddProjectViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: AddProjectDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
