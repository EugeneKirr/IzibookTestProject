//
//  AuthError.swift
//  IzibookTestProject
//
//  Created by Eugene Kireichev on 11/06/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import Foundation

struct AuthError: NetworkError, Codable {    
    
    let result: String
    let code: Int
    let reason: String
        
}
