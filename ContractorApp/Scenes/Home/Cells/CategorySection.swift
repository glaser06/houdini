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
    
    var cellData: [( String, (Int, UIImage?))] = []
    
    func setCell(data: [(String, Int, UIImage?)]) {
        let cats = ["AC and Heating", "Handyman",  "Electrician", "Home Cleaner", "Landscaper", "Roofing", "Mover", "Painter", "Plumber"]
        let imgs: [UIImage?] = [UIImage(named: "acrepair"),UIImage(named: "carpenter"),UIImage(named: "electrician"),UIImage(named: "cleaners"),UIImage(named: "landscaping"),UIImage(named: "roofing"),UIImage(named: "movers"),UIImage(named: "painter"),UIImage(named: "plumber2"), ]
        let counts: [Int] = [1,2,3,4,5,6,7,8,9]
        
        let zipped = Array(zip(cats, zip(counts, imgs)))
        self.cellData = zipped
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
        cell.setCell(name: data.0, count: data.1.0, img: data.1.1 ?? UIImage(named: "placeholder")!)
        //        print("here")
        return cell
    }
}
