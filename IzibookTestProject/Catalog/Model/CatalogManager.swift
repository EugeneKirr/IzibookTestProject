//
//  CatalogManager.swift
//  IzibookTestProject
//
//  Created by Eugene Kireichev on 12/06/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import UIKit

class CatalogManager {
    
    private var currentCatalog = Catalog(sections: [])
    
    func updateCatalog(from catalogData: CatalogData, _ imageDataset: [ImageData]) {
        var catalogSections = [CatalogSection]()
        for index in 0..<catalogData.data.count {
            var catalogItems = [CatalogItem]()
            for itemData in catalogData.data[index].items {
                let catalogItem = CatalogItem(id: itemData.id, sectionID: catalogData.data[index].id, title: itemData.title)
                catalogItems.append(catalogItem)
            }
            let catalogSection = CatalogSection(id: catalogData.data[index].id,
                                                image: UIImage(data: imageDataset[index]),
                                                title: catalogData.data[index].title,
                                                items: catalogItems,
                                                areItemsHidden: true)
            catalogSections.append(catalogSection)
        }
        catalogSections.sort { return $0.title < $1.title }
        currentCatalog = Catalog(sections: catalogSections)
    }
    
    func transmitCatalog() -> Catalog {
        return currentCatalog
    }
    
    func switchItemsStatus(forSection index: Int) {
        var updatedSections = currentCatalog.sections
        updatedSections[index] = CatalogSection(id: currentCatalog.sections[index].id,
                                                image: currentCatalog.sections[index].image,
                                                title: currentCatalog.sections[index].title,
                                                items: currentCatalog.sections[index].items,
                                                areItemsHidden: !currentCatalog.sections[index].areItemsHidden)
        currentCatalog = Catalog(sections: updatedSections)
    }
    
}
