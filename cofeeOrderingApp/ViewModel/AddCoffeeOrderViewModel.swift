//
//  AddCoffeeOrderViewModel.swift
//  cofeeOrderingApp
//
//  Created by karingula Lingaswami on 30/03/24.
//

import Foundation

struct AddCoffeeOrderViewModel {
    var name:String?
    var email:String?
    var selectedSize: String?
    var selectedType: String?
    
    var type:[String] {
        return CoffeeType.allCases.map { $0.rawValue.capitalized }
    }
    
    var size: [String] {
        return CoffeSize.allCases.map { $0.rawValue.capitalized }
    }
}
