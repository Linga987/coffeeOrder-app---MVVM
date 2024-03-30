//
//  Order.swift
//  cofeeOrderingApp
//
//  Created by karingula Lingaswami on 30/03/24.
//

import Foundation

enum CoffeeType: String, Codable, CaseIterable {
    case cappuccino
    case latte
    case espressino
    case cortado
}

enum CoffeSize: String, Codable, CaseIterable {
    case small
    case medium
    case large
}

struct Order: Codable {
    var name: String
    var email: String
    var type: CoffeeType
    var size: CoffeSize
}

extension Order {
    static var all: Resources<[Order]> = {
        guard let url = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else {
            fatalError("Invalis url")
        }
        
        return Resources<[Order]>(url: url)
    }()
    static func create(_ vm: AddCoffeeOrderViewModel) -> Resources<Order?> {
        let order = Order(vm)
        guard let url = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else {
            fatalError("Invalis url")
        }
        
        guard let data = try? JSONEncoder().encode(order) else {
            fatalError("encoding failed")
        }
        
        var resource = Resources<Order?>(url: url)
        resource.httpMethod = HttpMethod.post
        resource.body = data
        return resource
    }
}

extension Order {
    init?(_ vm: AddCoffeeOrderViewModel) {
        guard let name = vm.name,
              let email = vm.email,
              let selectedType = CoffeeType(rawValue: vm.selectedType!.lowercased()),
              let selectedSize = CoffeSize(rawValue: vm.selectedSize!.lowercased()) else {
            return nil
        }
        self.name = name
        self.email = email
        self.size = selectedSize
        self.type = selectedType
    }
}
