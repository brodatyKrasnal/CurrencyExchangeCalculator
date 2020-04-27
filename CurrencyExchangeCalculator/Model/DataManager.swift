//
// DataMechanism.swift
//  CurrencyExchangeCalculator
//
//  Created by Daniel Golęba Frygies on 23/04:114.
//  Copyright © 2020 Tymon Golęba Frygies. All rights reserved.
//

import Foundation

protocol DataManagerDelegate {
    func didGrabData (_ dataMechanism: DataManager, dataSet: DataModel)
    func didFailWithError (error: Error)
}

struct DataManager {
    
    var delegate: DataManagerDelegate?
    
    let currenciesList = ["CHF","EUR","GBP","USD","AED","AUD","BGN","CAD","CNY","CZK","DKK","HKD","HRK","HUF","ILS","JPY","MXN","NOK","NZD","RON","RUB","SEK","SGD","THB","TRY","ZAR"]
    
    var currencyName: [String:String] =
        ["CHF": "Swiss franc",
         "EUR": "Euro",
         "GBP": "British pound",
         "USD": "American dollar",
         "AED": "Dirham U.A.E.",
         "AUD": "Australian dollar",
         "BGN": "Bulgarian lev",
         "CAD": "Canadian dollar",
         "CNY": "Chinese yuan renminbi",
         "CZK": "Czech koruna",
         "DKK": "Danish krone",
         "HKD": "Hong Kong dollar",
         "HRK": "Croatian kuna",
         "HUF": "Hungarian forint",
         "ILS": "Israeli shekel",
         "JPY": "Japanese yen",
         "MXN": "Mexican peso",
         "NOK": "Norwegian krone",
         "NZD": "New Zealand dollar",
         "RON": "Romanian new leu",
         "RUB": "Russian ruble",
         "SEK": "Swedish krona",
         "SGD": "Singapore dollar",
         "THB": "Thai baht",
         "TRY": "Turkish lira",
         "ZAR": "South African rand",
    ]
    
    var currencyLocation: [String:String] =
        ["CHF":"A",
         "EUR": "A",
         "GBP": "A",
         "USD": "A",
         "AED": "B",
         "AUD": "A",
         "BGN": "A",
         "CAD": "A",
         "CNY": "A",
         "CZK": "A",
         "DKK": "A",
         "HKD": "A",
         "HRK": "A",
         "HUF": "A",
         "ILS": "A",
         "JPY": "A",
         "MXN": "A",
         "NOK": "A",
         "NZD": "A",
         "RON": "A",
         "RUB": "A",
         "SEK": "A",
         "SGD": "A",
         "THB": "A",
         "TRY": "A",
         "ZAR": "A",
    ]
    
    var table: String = ""
    let prefix = "https://api.nbp.pl/api/exchangerates/rates/"
    let sufix = "/?format=JSON"
    
    func fetchData (currency: String) {
        let urlString = "\(prefix)\(currencyLocation[currency]!)/\(currency)\(sufix)"
        print(urlString)
        
        //1. Create URL
        
        if let url = URL(string: urlString) {
            //2. Create session
            let session =  URLSession(configuration: .default)
            //3. assign task
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let dataObtained  = self.parseJSON(safeData) {
                        self.delegate?.didGrabData(self, dataSet: dataObtained)
                        print(String(data: safeData, encoding: .utf8)!)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ dataSet: Data) -> DataModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(DataStructure.self, from: dataSet)
            let rate = decodedData.rates[0].mid
            let currency = decodedData.code
            let dataObtained = DataModel(code: currency, mid: rate)
            return dataObtained
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
        
    }
    
    
    
    
}
