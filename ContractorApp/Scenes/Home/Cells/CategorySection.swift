//
//  CategorySection.swift
//  ContractorApp
//
//  Created by Zaizen Kaegyoshi on 11/27/17.
//  Copyright © 2017 Team5. All rights reserved.
//

import UIKit

class CategorySection: UICollectionReusableView {

    let identifier = "ContractorCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.categoriesCollectionView.register(UINib(nibName: "TallContractorCollectionCell", bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    var cellData: [(tag: String, count: Int, img: UIImage)] = []
    
    func setCell(data: [(tag: String, count: Int, img: UIImage)]) {
        self.cellData = data
        self.categoriesCollectionView.reloadData()
    }
    
}

extension CategorySection: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! TallContractorCollectionCell
        let data = cellData[indexPath.row % cellData.count]
        cell.setCell(name: data.tag, count: data.count, img: data.img)
        //        print("here")
        return cell
    }
}
