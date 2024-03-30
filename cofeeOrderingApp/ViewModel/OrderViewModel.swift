//
//  OrderViewModel.swift
//  cofeeOrderingApp
//
//  Created by karingula Lingaswami on 30/03/24.
//

import Foundation

struct OrderListViewModel {
    var orderViewModel: [OrderViewModel]
    
    init() {
        self.orderViewModel = [OrderViewModel]()
    }
}

extension OrderListViewModel {
    func orederViewModel(at index: Int) -> OrderViewModel {
        return self.orderViewModel[index]
    }
}

struct OrderViewModel {
    var order: Order
}

extension OrderViewModel {
    var name: String {
        return order.name
    }
    
    var email:String {
        return order.email
    }
    
    var type: String {
        return order.type.rawValue.capitalized
    }
    
    var size:String {
        return order.size.rawValue.capitalized
    }
}
