//
//  AuthResponse.swift
//  IzibookTestProject
//
//  Created by Eugene Kireichev on 11/06/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import Foundation

struct AuthResponse: Codable {
    
    let result: String
    let data: AuthData
    
}

struct AuthData: Codable {

    let pkcs12: String
    
}
