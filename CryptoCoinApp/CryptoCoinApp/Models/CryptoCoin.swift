//
//  CryptoCoin.swift
//  CryptoCoinApp
//
//  Created by Subrat Padhi on 21/10/24.
//

import Foundation

struct CryptoCoin: Decodable {
    let name: String
    let symbol: String
    let type: String
    let isActive: Bool
    let isNew: Bool
    
    enum CodingKeys: String, CodingKey {
        case name, symbol, type
        case isActive = "is_active"
        case isNew = "is_new"
    }
}
