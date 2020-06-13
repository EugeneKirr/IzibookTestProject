//
//  CatalogItemCell.swift
//  IzibookTestProject
//
//  Created by Eugene Kireichev on 12/06/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import UIKit

class CatalogItemCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func loadView(_ itemTitle: String) {
        titleLabel.text = itemTitle
    }
    
}
