//
//  CatalogPendingCell.swift
//  IzibookTestProject
//
//  Created by Eugene Kireichev on 12/06/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import UIKit

class CatalogPendingCell: UICollectionViewCell {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        activityIndicatorView.startAnimating()
    }
    
}
