//
//  CryptoImage.swift
//  CryptoCoinApp
//
//  Created by Subrat Padhi on 21/10/24.
//

import UIKit

enum CryptoImage {
    case activeCoin
    case activeToken
    case inactive
    
    var image: UIImage? {
        switch self {
        case .activeCoin:
            return UIImage(named: "bitcoin")
        case .activeToken:
            return UIImage(named: "token")
        case .inactive:
            return UIImage(named: "inactive")
        }
    }
    
    static func forCoin(coin: CryptoCoin) -> CryptoImage {
        if coin.isActive {
            switch coin.type {
            case "coin":
                return .activeCoin
            case "token":
                return .activeToken
            default:
                return .inactive
            }
        } else {
            return .inactive
        }
    }
}

