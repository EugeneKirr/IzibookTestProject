//
//  CatalogSection.swift
//  IzibookTestProject
//
//  Created by Eugene Kireichev on 12/06/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import UIKit

struct CatalogSection {
    
    let id: Int
    let image: UIImage
    let title: String
    let items: [CatalogItem]
    let areItemsHidden: Bool
    
    init(id: Int, image: UIImage?, title: String, items: [CatalogItem], areItemsHidden: Bool) {
        self.id = id
        self.image = image ?? UIImage(systemName: "photo")!
        self.title = title
        self.items = items
        self.areItemsHidden = areItemsHidden
    }
    
}
