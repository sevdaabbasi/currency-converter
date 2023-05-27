//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Sevda Abbasi on 27.05.2023.
//

import Foundation


class Currency {
    
    var name  : String
    var values : Double = 0
    
    
    init(name: String, values: Double) {
        self.name = name
        self.values = values
    }
    
}

