//
//  NetworkError.swift
//  IzibookTestProject
//
//  Created by Eugene Kireichev on 13/06/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import Foundation

protocol NetworkError: Error {
    
    var reason: String { get }
    
}
