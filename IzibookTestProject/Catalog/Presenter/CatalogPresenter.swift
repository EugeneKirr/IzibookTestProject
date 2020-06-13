//
//  CatalogPresenter.swift
//  IzibookTestProject
//
//  Created by Eugene Kireichev on 12/06/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import Foundation

class CatalogPresenter {
    
    private let networkManager = NetworkManager()
    
    private let catalogManager = CatalogManager()
    
    weak var view: PresenterInteractable?
    
    required init(_ viewToInteract: PresenterInteractable) {
        self.view = viewToInteract
    }
    
}

extension CatalogPresenter: ViewInteractable {
    
    func viewDidLoad() {
        view?.initSetup()
        networkManager.downloadCatalogData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                guard let networkError = error as? NetworkError else { return }
                self.view?.showErrorAlert(with: networkError.reason)
            case .success(let data):
                self.catalogManager.updateCatalog(from: data.0, data.1)
                self.view?.updateViewModel(with: self.catalogManager.transmitCatalog())
                self.view?.reloadView()
            }
        }
    }
    
    func implementResponse(for indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            catalogManager.switchItemsStatus(forSection: indexPath.section)
            view?.updateViewModel(with: catalogManager.transmitCatalog())
            view?.reloadSection(with: indexPath.section)
        default: return
        }
    }
    
}
