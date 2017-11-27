//
//  AddProjectInteractor.swift
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

protocol AddProjectBusinessLogic
{
    func fetchPhotos()
    func addProject(request: AddProject.AddProject.Request)
    func fetchProject()
}

protocol AddProjectDataStore
{
    //var name: String { get set }
    var project: Project? { get set }
    var business: Business! { get set }
}

class AddProjectInteractor: AddProjectBusinessLogic, AddProjectDataStore
{
    var presenter: AddProjectPresentationLogic?
    var worker: AddProjectWorker?
    //var name: String = ""
    var project: Project?
    var business: Business!
    
    func fetchProject() {
        ProjectWorker.sharedInstance.images = []
        if project != nil {
            let proj: Project = self.project!
            ProjectWorker.sharedInstance.images = proj.images
            let resp = AddProject.FetchProject.Response(project: proj)
            self.presenter?.presentProject(response: resp)
        }
    }
    
    // MARK: Do something
    
    func fetchPhotos() {
        let response = AddProject.FetchPhotos.Response(images: ProjectWorker.sharedInstance.images)
        self.presenter?.presentPhotos(response: response)
    }
    func addProject(request: AddProject.AddProject.Request) {
        let project = Project(name: request.name, detail: request.details, type: request.jobType)
        project.images = ProjectWorker.sharedInstance.images
        
        ProjectWorker.sharedInstance.projects.append(project)
        MessengerWorker.sharedInstance.conversations.append(Conversation(busi: business, proj: project))
    }
}