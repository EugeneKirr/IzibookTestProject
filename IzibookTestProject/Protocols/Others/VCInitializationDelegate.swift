//
//  VCInitializationDelegate.swift
//  IzibookTestProject
//
//  Created by Eugene Kireichev on 12/06/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import UIKit

protocol VCInitializationDelegate {
    
    func initializeViewController(_ vcType: PresenterInteractable.Type, with presenterType: ViewInteractable.Type) -> PresenterInteractable
    
}

extension VCInitializationDelegate {
    
    func initializeViewController(_ vcType: PresenterInteractable.Type, with presenterType: ViewInteractable.Type) -> PresenterInteractable {
        let vcIdentifier = String(describing: vcType)
        let sbName = String(vcIdentifier.dropLast("ViewController".count))
        
        let sb = UIStoryboard(name: sbName, bundle: nil)
        guard let vc = sb.instantiateViewController(identifier: vcIdentifier) as? PresenterInteractable else { fatalError() }
        vc.presenter = presenterType.init(vc)
        return vc
    }
    
}
