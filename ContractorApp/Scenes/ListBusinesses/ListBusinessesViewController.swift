//
//  ListBusinessesViewController.swift
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

protocol ListBusinessesDisplayLogic: class
{
    func displayBusinesses(viewModel: ListBusinesses.FetchBusinesses.ViewModel)
    func displayAll(viewModel: ListBusinesses.FetchAll.ViewModel)
    func displaySearch(viewModel: ListBusinesses.Search.ViewModel)
    func displayCategories(vm: ListBusinesses.FetchCategories.ViewModel)
}

class ListBusinessesViewController: UIViewController, ListBusinessesDisplayLogic
{
    var interactor: ListBusinessesBusinessLogic?
    var router: (NSObjectProtocol & ListBusinessesRoutingLogic & ListBusinessesDataPassing)?
    
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
        let interactor = ListBusinessesInteractor()
        let presenter = ListBusinessesPresenter()
        let router = ListBusinessesRouter()
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
    
    var businesses: [ListBusinesses.Search.ViewModel.DisplayableBusiness] = []
    var cellData: [String: [(name: String, image: UIImage)]] = [:]
    var categories: [(String, UIImage?)] = []
    
    var isSearch: Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.isSearch = false
        self.navigationController?.clearShadow()
        if let a  = categoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            a.headerReferenceSize = CGSize(width: 0, height: 50)
        }
        categoryCollectionView.register(UINib(nibName: "BusinessCollectionCell", bundle: nil), forCellWithReuseIdentifier: "BusinessCell")
//        self.categoryCollectionView.register(UINib(nibName: "DisplayCategoryTableCell", bundle: nil), forCellReuseIdentifier: "DisplayCategoryCell")
//        self.categoryCollectionView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "ContractorCell")
        
//        self.categoryCollectionView.estimatedRowHeight = 120
//        self.categoryTableView.rowHeight = UITableViewAutomaticDimension
        fetchCategories()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    // MARK: Do something
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UITextField!
    
    func fetchBusinesses() {
        self.interactor?.fetchBusinesses()
    }
    func fetchAll() {
        self.interactor?.fetchAll()
    }
    func fetchCategories () {
        self.interactor?.fetchCategories()
    }
    func search() {
        let req = ListBusinesses.Search.Request(query: self.searchBar.text!)
        self.interactor?.search(request: req)
    }
    func displaySearch(viewModel: ListBusinesses.Search.ViewModel) {
        self.isSearch = true
        self.searchBar.text = viewModel.query
        let results = viewModel.businesses
        self.businesses = results
        self.categoryCollectionView.reloadData()
    }
    
    func displayBusinesses(viewModel: ListBusinesses.FetchBusinesses.ViewModel) {
//        self.businesses = viewModel.businesses
        self.categoryCollectionView.reloadData()
    }
    func displayAll(viewModel: ListBusinesses.FetchAll.ViewModel) {
        self.isSearch = false
        self.cellData = viewModel.data
        self.categoryCollectionView.reloadData()
    }
    func displayCategories(vm: ListBusinesses.FetchCategories.ViewModel) {
         self.categories = vm.categories
        self.categoryCollectionView.reloadData()
    }
    
    var selectedCategory: String = ""
    var selectedIndex: Int = 0
    func checkSearch() -> Bool {
        if self.searchBar.text != "" {
            
            self.isSearch = true
            return true
        } else {
            self.isSearch = false
            self.fetchAll()
            return false
        }
        
    }
    @IBAction func back() {
        self.navigationController?.popViewController(animated: true)
    }
}
extension ListBusinessesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BusinessCell", for: indexPath) as! BusinessCollectionCell
        let data = categories[indexPath.row]
        cell.setCell(name: data.0, img: data.1)
        return cell
    }
}
extension ListBusinessesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let v = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "titleHeader", for: indexPath)
        return v
    }
    
}
//extension ListBusinessesViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isSearch {
//            return businesses.count
//        } else {
//            return cellData.count
//        }
//
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print(isSearch)
//        if !isSearch {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "DisplayCategoryCell") as! DisplayCategoryTableCell
//
//
//            if indexPath.row == 0 {
//                let source = self.cellData["History"]!
//                cell.setCell(category: "History", data: source, transition: { (category, index) in
//                    self.selectedIndex = index
//                    self.selectedCategory = "History"
//                    self.searchBar.text = category
//                    self.search()
//                })
//            } else {
//                let source = self.cellData["Favorites"]!
//                cell.setCell(category: "Favorites", data: source, transition: { (category, index) in
//                    self.selectedIndex = index
//                    self.selectedCategory = "Favorites"
//                    self.performSegue(withIdentifier: "ShowBusiness", sender: self)
//                })
//            }
//
//            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ContractorCell") as! ReviewTableViewCell
//            let biz = self.businesses[indexPath.row]
//            cell.setCell(name: biz.name, img: biz.image, rank: biz.rank)
//            return cell
//        }
//
//    }
//
//}
//extension ListBusinessesViewController: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("asdf")
//
//        if checkSearch() {
//            self.selectedIndex = indexPath.row
//            self.selectedCategory = "Search"
//            self.performSegue(withIdentifier: "ShowBusiness", sender: self)
//        }
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//}
extension ListBusinessesViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if checkSearch() {
            search()
        }
        
        textField.resignFirstResponder()
        self.view.endEditing(true)

        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
}
