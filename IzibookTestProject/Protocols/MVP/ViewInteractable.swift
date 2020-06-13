//
//  ViewInteractable.swift
//  IzibookTestProject
//
//  Created by Eugene Kireichev on 12/06/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import Foundation

protocol ViewInteractable: AnyObject {
    
    var view: PresenterInteractable? { get set }
    
    init(_ viewToInteract: PresenterInteractable)
    
    func viewDidLoad()
    
    func implementResponse(for indexPath: IndexPath)
    
}
