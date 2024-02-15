//
//  Cases.swift
//  AppIosW6CodePatroll_Example
//
//  Created by Estefania Sassone on 23/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import Foundation

public enum SearchCase {
    
    case auto
    case moto
    case truck
    case estate
    case favorites
    
    var CategoryId: String {
        switch self {
        case .auto:
            return "MLA1744"
        case .moto:
            return "MLA1763"
        case .truck:
            return "MLA58254"
        case .estate:
            return "MLA1459"
        case .favorites:
            return ""
        }
    }
}
