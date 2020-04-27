//
//  ExchangeModel.swift
//  CurrencyExchangeCalculator
//
//  Created by Daniel Golęba Frygies on 24/04:115.
//  Copyright © 2020 Tymon Golęba Frygies. All rights reserved.
//

import Foundation

struct DataStructure: Decodable {
    let rates: [Rates]
    let code: String
}

struct Rates: Decodable {
    let mid: Double
}

