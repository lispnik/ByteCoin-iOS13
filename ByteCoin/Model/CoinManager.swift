//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {

    let baseURL = URL(string: "https://rest.coinapi.io/v1/exchangerate/BTC/")!
    let apiKey = "71046DC4-7F4E-407C-BD2E-6887DD9D2AB8"
    let currencyArray = ["AUD", "BRL", "CAD", "CNY", "EUR", "GBP", "HKD", "IDR", "ILS", "INR", "JPY", "MXN", "NOK", "NZD", "PLN", "RON", "RUB", "SEK", "SGD", "USD", "ZAR"]
    
    var delegate: CoinManagerDelegate?

    func getCoinPrice(for currency: String) {
        let url = URL(string: currency, relativeTo: baseURL)
        let urlSession = URLSession.shared
        var urlRequest = URLRequest(url: url!)
        urlRequest.addValue(apiKey, forHTTPHeaderField: "X-CoinAPI-Key")
        let task = urlSession.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if let error = error {
                print(error)
            } else {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let coinRate = try decoder.decode(CoinRate.self, from: data)
                        DispatchQueue.main.async {
                            self.delegate?.didFetchCoinPrice(rate: coinRate.rate, currency: currency)
                        }
                     } catch {
                        print(error)
                    }
                }
            }
        }
        task.resume()

    }
}

protocol CoinManagerDelegate {
    
    func didFetchCoinPrice(rate: Double, currency: String)
}
