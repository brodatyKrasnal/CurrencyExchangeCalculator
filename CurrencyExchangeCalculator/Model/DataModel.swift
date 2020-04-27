//
//  DataModel.swift
//  CurrencyExchangeCalculator
//
//  Created by Daniel Golęba Frygies on 24/04:115.
//  Copyright © 2020 Tymon Golęba Frygies. All rights reserved.
//

import Foundation

struct DataModel {

    let code: String
    let mid: Double
    
    var midString:String {
        String(format: "%.2f",mid )
    }
    
}
