
//
//  APIService.swift
//  CryptoCoinApp
//
//  Created by Subrat Padhi on 21/10/24.
//

import Foundation

class APIService {
    
    func getCryptoData(completion: @escaping (Result<[CryptoCoin], Error>) -> Void) {
        let url = URL(string: "https://37656be98b8f42ae8348e4da3ee3193f.api.mockbin.io/")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let cryptoData = try JSONDecoder().decode([CryptoCoin].self, from: data)
                completion(.success(cryptoData))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}
