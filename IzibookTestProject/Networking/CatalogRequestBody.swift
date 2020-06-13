//
//  CatalogRequestBody.swift
//  IzibookTestProject
//
//  Created by Eugene Kireichev on 11/06/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import Foundation

struct CatalogRequestBody: Codable {
    
    let filter: Filter
    let view: [Item]
    
}

struct Filter: Codable {
    
    let parent: Int
    
}

struct Item: Codable {
    
    let code: String
    let view: [Item]?
    
    init(code: String, view: [Item]? = nil) {
        self.code = code
        self.view = view
    }
    
}


