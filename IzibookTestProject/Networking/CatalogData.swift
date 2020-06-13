//
//  CatalogData.swift
//  IzibookTestProject
//
//  Created by Eugene Kireichev on 11/06/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import Foundation

struct CatalogData: Codable {
    
    let result: String
    let results: Int
    let data: [CatalogSectionData]
    
}

struct CatalogSectionData: Codable {
    
    let popularity: Bool
    let icon: String
    let title: String
    let id: Int
    let items: [CatalogItemData]
    
}

struct CatalogItemData: Codable {
    
    let id: Int
    let title: String
    
}
