//
//  ListProjectsInteractor.swift
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

protocol ListProjectsBusinessLogic
{
    func fetchProjects()
    func addConversation(index: Int)
}

protocol ListProjectsDataStore
{
    //var name: String { get set }
    var doSelect: Bool { get set }
    var projects: [Project] { get set }
}

class ListProjectsInteractor: ListProjectsBusinessLogic, ListProjectsDataStore
{
    var presenter: ListProjectsPresentationLogic?
    var worker: ListProjectsWorker?
    //var name: String = ""
    var doSelect: Bool = false
    var projects: [Project] = []
    // MARK: Do something
    
    func fetchProjects() {
        self.projects = ProjectWorker.sharedInstance.projects
        presenter?.presentProjects(response: ListProjects.FetchProjects.Response(projects: ProjectWorker.sharedInstance.projects, doSelect: doSelect)) 
    }
    func addConversation(index: Int) {
        MessengerWorker.sharedInstance.conversations.append(Conversation(busi: ListBusinessesWorker.shared.businesses.first!.value.first!, proj: projects[index]))
    }
    
}