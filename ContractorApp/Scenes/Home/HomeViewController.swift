//
//  HomeViewController.swift
//  ContractorApp
//
//  Created by Zaizen Kaegyoshi on 11/8/17.
//  Copyright (c) 2017 Team5. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import UPCarouselFlowLayout
import Hero

protocol HomeDisplayLogic: class
{
    func displayCategories(viewModel: Home.FetchCategories.ViewModel)
    
    func displayBusinesses(viewModel: Home.FetchBusinesses.ViewModel)
    
    func updateImage(vm: Home.UpdateImage.ViewModel)
}

class HomeViewController: UIViewController, HomeDisplayLogic
{
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
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
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
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
    
    struct Identifier {
        static var categoryCell: String = "CategoryCell"
        static var categorySection: String = "CategoryHeader"
        static var titleSection: String = "TitleHeader"
        static var businessCell: String = "BusinessCell"
    }
    
    var cellData: [(tag: String, count: Int, img: UIImage)] = []
    var businesses: [String: [Home.FetchBusinesses.ViewModel.DisplayableBusiness]] = [:]
    var categories: [String] = []
    let layout = UPCarouselFlowLayout()
    
    var searchVC: ListBusinessesViewController!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.heroNavigationAnimationType = .fade
//        self.tabBarController?.tabBar.isHidden = true
        self.automaticallyAdjustsScrollViewInsets = false
        self.categoriesCollectionView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        self.categoriesCollectionView.register(UINib(nibName: "TallContractorCollectionCell", bundle: nil), forCellWithReuseIdentifier: Identifier.categoryCell)
        self.categoriesCollectionView.register(UINib(nibName: "CategorySection", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Identifier.categorySection)
        self.categoriesCollectionView.register(UINib(nibName: "TitleSectionHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Identifier.titleSection)
        self.categoriesCollectionView.register(UINib(nibName: "BusinessHomeCell", bundle: nil), forCellWithReuseIdentifier: Identifier.businessCell)
        //        self.tabBarController?.tabBar.backgroundColor = UIColor.black
//        self.tabBarController?.tabBar.barTintColor = UIColor.black
        //        let layout = UPCarouselFlowLayout()
//        layout.itemSize = CGSize(width: 259, height: 390)
        //        self.categoriesCollectionView.collectionViewLayout = layout
        self.navigationController?.clearShadow()
        
        self.categoriesCollectionView.backgroundColor = UIColor.clear
        self.fetchCategories()
        self.fetchBusinesses()
        self.navigationController?.navigationBar.isHidden = true
        self.searchVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchVC") as! ListBusinessesViewController
        
        self.categoriesCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    override func viewDidDisappear(_ animated: Bool) {

    }
    override func viewWillDisappear(_ animated: Bool) {
//        self.navigationController?.navigationBar.barTintColor =
//        self.navigationController?.navigationBar.layer.zPosition = 0
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: Do something
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    
    
    
    func fetchCategories() {
        self.interactor?.fetchCategories()
        self.categoriesCollectionView.reloadSections(IndexSet(integer: 0))
    }
    func fetchBusinesses() {
        self.interactor?.fetchBusinesses()
    }
    func displayCategories(viewModel: Home.FetchCategories.ViewModel) {
        self.cellData = viewModel.data
        self.categoriesCollectionView.reloadSections(IndexSet(integer: 0))
    }
    func displayBusinesses(viewModel: Home.FetchBusinesses.ViewModel) {
        
        if self.categories.count == 0 {
            self.businesses = viewModel.businesses
            
            self.categories = Array(self.businesses.keys)
            self.categoriesCollectionView.reloadData()
        } else {
            self.businesses = viewModel.businesses
            
            self.categories = Array(self.businesses.keys)
            self.categoriesCollectionView.reloadSections(IndexSet(integersIn: 1...self.businesses.count))
        }
       
        
        
    }
    func updateImage(vm: Home.UpdateImage.ViewModel) {
        self.businesses[vm.section]![vm.index].image = vm.image
        let indexPath: IndexPath = IndexPath(row: vm.index, section: self.categories.index(of: vm.section)! + 1)
        if self.businesses.count > 0 {
            self.categoriesCollectionView.reloadItems(at: [indexPath])
        }
        
        
        
    }
    @IBAction func pushToSearch() {
        self.navigationController?.heroNavigationAnimationType = .fade
        self.navigationController?.pushViewController(searchVC, animated: true)
        
        
    }
    
}
extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.categories.count + 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else {
            let count = businesses[categories[section-1]]!.count
            return count < 4 ? count : 4
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.businessCell, for: indexPath) as! BusinessHomeCell
        let key = self.categories[indexPath.section - 1]
        let data: Home.FetchBusinesses.ViewModel.DisplayableBusiness = self.businesses[key]![indexPath.row]
        cell.setCell(name: data.name, img: data.image, category: data.type.uppercased(), reviewCount: "\(data.reviewCount)")
        //        print("here")
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Identifier.categorySection, for: indexPath) as! CategorySection
            header.setCell(data: [])
            return header
        } else {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Identifier.titleSection, for: indexPath) as! TitleSectionHeader
            header.setCell(title: categories[indexPath.section - 1].capitalized)
            return header
        }
        
    }
    
}
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.router?.routeToListBusinesses()
        self.performSegue(withIdentifier: "ShowBusiness", sender: self)
        collectionView.deselectItem(at: indexPath, animated: false)
    }
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: self.view.frame.width, height: 328)
        } else {
            return CGSize(width: self.view.frame.width, height: 45)
        }
    }
}






























