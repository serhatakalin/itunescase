//
//  DetailItem.swift
//  itunescase
//
//  Created by Serhat Akalin on 16.02.2019.
//  Copyright © 2019 Serhat Akalin. All rights reserved.
//

import Foundation

public enum DetailItem {
    case upc(String)
    case isbn(String)
    case id(String)
    
    var parameters: [String: String] {
        switch self {
        case .upc(let upc):
            return ["upc": upc]
        case .isbn(let isbn):
            return ["isbn": isbn]
        case .id(let id):
            return ["id": id]
        }
    }
}
