//
//  DisplayCategoryTableCell.swift
//  ContractorApp
//
//  Created by Zaizen Kaegyoshi on 10/25/17.
//  Copyright © 2017 Team5. All rights reserved.
//

import UIKit

protocol CategoryCellDelegate {
    
}

class DisplayCategoryTableCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        businessCollectionView.register(UINib(nibName: "BusinessCollectionCell", bundle: nil), forCellWithReuseIdentifier: "BusinessCard")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var businessCollectionView: UICollectionView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var businesses: [ListBusinesses.FetchBusinesses.ViewModel.DisplayableBusiness] = []
    var transition:  (String, Int) -> Void = {(a,b) in }
    var data: [(String, UIImage)] = []
    
    func setCell(category: String, data: [(String, UIImage)], transition: @escaping (String, Int) -> Void) {
        self.categoryLabel.text = category
//        self.businesses = businesses
        self.data = data
        self.businessCollectionView.reloadData()
        self.transition = transition
        
    }
    
    
}
extension DisplayCategoryTableCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BusinessCard", for: indexPath) as! BusinessCollectionCell
        let d = data[indexPath.row]
        cell.setCell(name: d.0, img: d.1)
        return cell
    }
}
extension DisplayCategoryTableCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.transition(self.data[indexPath.item].0, indexPath.item)
    }
}
