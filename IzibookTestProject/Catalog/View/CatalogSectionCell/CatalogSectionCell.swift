//
//  CatalogSectionCell.swift
//  IzibookTestProject
//
//  Created by Eugene Kireichev on 12/06/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import UIKit

class CatalogSectionCell: UICollectionViewCell {
    
    @IBOutlet weak var sectionImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var chevronImageView: UIImageView!
    
    func loadView(_ sectionTitle: String, _ sectionImage: UIImage?, _ isChevronPointsDown: Bool) {
        layoutIfNeeded()
        titleLabel.text = sectionTitle
        sectionImageView.image = sectionImage
        sectionImageView.layer.cornerRadius = sectionImageView.bounds.height/2
        chevronImageView.image = isChevronPointsDown ? UIImage(systemName: "chevron.down") : UIImage(systemName: "chevron.up")
    }
    
}
