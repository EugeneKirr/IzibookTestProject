//
//  CatalogDataProvider.swift
//  IzibookTestProject
//
//  Created by Eugene Kireichev on 12/06/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import UIKit

class CatalogDataProvider: NSObject {
    
    weak var delegate: InterfaceActionDelegate?
    
    var catalogToDisplay = Catalog(sections: [])
    
    private var isInPendingMode: Bool {
        return catalogToDisplay.sections.count == 0
    }
    
}

extension CatalogDataProvider: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard !isInPendingMode else { return 1 }
        return catalogToDisplay.sections.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard !isInPendingMode else { return 1 }
        switch catalogToDisplay.sections[section].areItemsHidden {
        case true: return 1
        case false: return (catalogToDisplay.sections[section].items.count + 1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard !isInPendingMode else {
            return collectionView.dequeueReusableCell(CatalogPendingCell.self, for: indexPath, configuration: nil)
        }
        switch indexPath.row {
        case 0:
            return collectionView.dequeueReusableCell(CatalogSectionCell.self, for: indexPath) { [catalogToDisplay] cell in
                cell.loadView(catalogToDisplay.sections[indexPath.section].title, catalogToDisplay.sections[indexPath.section].image, catalogToDisplay.sections[indexPath.section].areItemsHidden)
            }
        default:
            return collectionView.dequeueReusableCell(CatalogItemCell.self, for: indexPath) { [catalogToDisplay] cell in
                cell.loadView(catalogToDisplay.sections[indexPath.section].items[(indexPath.row - 1)].title)
            }
        }
        
    }
    
    // MARK: - Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard !isInPendingMode else { return }
        delegate?.selectItem(with: indexPath)
    }    
    
}

extension CatalogDataProvider: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
        let totalHeight = collectionView.safeAreaLayoutGuide.layoutFrame.height
        guard !isInPendingMode else { return collectionView.safeAreaLayoutGuide.layoutFrame.size }
        switch indexPath.row {
        case 0: return CGSize(width: totalWidth, height: 0.15 * totalHeight)
        default: return CGSize(width: totalWidth, height: 0.125 * totalHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0)
    }
    
}
