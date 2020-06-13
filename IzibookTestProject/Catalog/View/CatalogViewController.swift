//
//  CatalogViewController.swift
//  IzibookTestProject
//
//  Created by Eugene Kireichev on 11/06/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import UIKit

class CatalogViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let dataProvider = CatalogDataProvider()
    
    var presenter: ViewInteractable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

}

extension CatalogViewController: PresenterInteractable {
    
    func initSetup() {
        dataProvider.delegate = self
        collectionView.dataSource = dataProvider
        collectionView.delegate = dataProvider
        [CatalogSectionCell.self, CatalogItemCell.self, CatalogPendingCell.self].forEach { collectionView.register($0) }
    }
    
    func updateViewModel(with dataModel: ViewDisplayable) {
        guard let catalog = dataModel as? Catalog else { return }
        dataProvider.catalogToDisplay = catalog
    }
    
    func reloadView() {
        collectionView.reloadData()
    }
    
    func reloadSection(with index: Int) {
        collectionView.reloadSections(IndexSet(integer: index))
    }
    
    func showErrorAlert(with description: String) {
        let ac = UIAlertController(title: description, message: "Попробуйте запустить\nприложение позже", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        ac.addAction(ok)
        present(ac, animated: true, completion: nil)
    }
    
}

extension CatalogViewController: InterfaceActionDelegate {
    
    func selectItem(with indexPath: IndexPath) {
        presenter?.implementResponse(for: indexPath)
    }
    
}
