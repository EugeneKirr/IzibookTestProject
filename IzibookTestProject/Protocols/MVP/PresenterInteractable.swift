//
//  PresenterInteractable.swift
//  IzibookTestProject
//
//  Created by Eugene Kireichev on 12/06/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import UIKit

protocol PresenterInteractable: UIViewController {
    
    var presenter: ViewInteractable? { get set }
    
    func initSetup()
    
    func updateViewModel(with dataModel: ViewDisplayable)
    
    func reloadView()
    
    func reloadSection(with index: Int)
    
    func showErrorAlert(with description: String)
    
}
