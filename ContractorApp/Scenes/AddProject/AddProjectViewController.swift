//
//  AddProjectViewController.swift
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

protocol AddProjectDisplayLogic: class
{
    func displayPhotos(viewModel: AddProject.FetchPhotos.ViewModel)
    func displayProject(viewModel: AddProject.FetchProject.ViewModel)
}

class AddProjectViewController: UIViewController, AddProjectDisplayLogic
{
    var interactor: AddProjectBusinessLogic?
    var router: (NSObjectProtocol & AddProjectRoutingLogic & AddProjectDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = AddProjectInteractor()
        let presenter = AddProjectPresenter()
        let router = AddProjectRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    var isFirstLoad: Bool = true
    
    var images: [UIImage] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.clearShadow()
//        self.navigationController
        self.multimediaCollectionView.register(UINib(nibName: "AddImageCollectionCell", bundle: nil), forCellWithReuseIdentifier: "AddImageCell")
//        self.fetchProject()
//        self.view.addTapToDismiss()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        if isFirstLoad {
//            showCamera()
//            isFirstLoad = false
//        }
//        self.fetchPhotos()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
//        fetchPhotos()
    }
    
    
    // MARK: Do something
    
    @IBOutlet weak var multimediaCollectionView: UICollectionView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var detailField: UITextView!
//    @IBOutlet weak var typeField: UITextField!
    
//    @IBOutlet weak var 
    
    func showCamera() {
        self.performSegue(withIdentifier: "AddMultimedia", sender: self)
    }
    
    @IBAction func createProject() {
        if nameField.text == nil || nameField.text == "" {
            return
        }
        self.interactor?.addProject(request: AddProject.AddProject.Request(name: nameField.text ?? nameField.placeholder ?? "", jobType: "", details: detailField.text))
        ProjectWorker.sharedInstance.images = []
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func close() {
//        self.presentingViewController!.navigationController!.tabBarController!.selectedIndex = 2
        self.dismiss(animated: true, completion: nil)
        
        ProjectWorker.sharedInstance.images = []
    }
    func fetchPhotos() {
        self.interactor?.fetchPhotos()
    }
    func displayPhotos(viewModel: AddProject.FetchPhotos.ViewModel) {
        self.images = viewModel.images
        self.multimediaCollectionView.reloadData()
    }
    func fetchProject() {
        self.interactor?.fetchProject()
    }
    func displayProject(viewModel: AddProject.FetchProject.ViewModel) {
        self.images = viewModel.images
        self.nameField.text = viewModel.name
        self.detailField.text = viewModel.details
//        self.typeField.text = viewModel.jobType
        self.multimediaCollectionView.reloadData()
        isFirstLoad = false
        
        self.navigationItem.leftBarButtonItem = nil
//        self.navigationItem.rightBarButtonItem = nil
        self.nameField.isUserInteractionEnabled = false
//        self.typeField.isUserInteractionEnabled = false
//        self.typeField.isUserInteractionEnabled = falsea  
        self.navigationItem.hidesBackButton = false
    }
}
extension AddProjectViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        showCamera()
        collectionView.deselectItem(at: indexPath, animated: false)
    }
}
extension AddProjectViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count + 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddImageCell", for: indexPath) as! AddImageCollectionCell
        print(images.count)
        if indexPath.item >= images.count {
            cell.setCell(image: #imageLiteral(resourceName: "plus-black"))
            return cell
        } else {
            cell.setCell(image: self.images[indexPath.item])
            
            return cell
        }
        
    }
}
extension AddProjectViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        textField.resignFirstResponder()
        return true
    }
}


