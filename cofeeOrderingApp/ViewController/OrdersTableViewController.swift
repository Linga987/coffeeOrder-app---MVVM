//
//  OrdersTableViewController.swift
//  cofeeOrderingApp
//
//  Created by karingula Lingaswami on 29/03/24.
//

import Foundation
import UIKit

class OrdersTableViewController: UITableViewController, AddCoffeeOrderDelegate {
   
    var orederListViewModel = OrderListViewModel()
    override func viewDidLoad() {
       super.viewDidLoad()
        
        populateOrders()
    }
    
    private func populateOrders() {
        WebService().load(resource: Order.all) { [weak self] result in
            switch result {
            case .success(let orders):
                self?.orederListViewModel.orderViewModel = orders.map(OrderViewModel.init)
                self?.tableView.reloadData()
            case.failure(let error):
                print(error)
            }
        }
        
    }
    
    func addCoffeeOrderViewCOntrollerDidSave(oreder: Order, controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
        
        let orderVc = OrderViewModel(order: oreder)
        self.orederListViewModel.orderViewModel.append(orderVc)
        self.tableView.insertRows(at: [IndexPath.init(row: self.orederListViewModel.orderViewModel.count - 1, section: 0)], with: .automatic)
    }
    
    func addOrdersViewControllerDidClose(controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController, let addCoffeeOrderVc = navC.viewControllers.first as? AddOrdersViewController else {
            fatalError("error performing segue")
        }
        
        addCoffeeOrderVc.delegate = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orederListViewModel.orderViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = orederListViewModel.orederViewModel(at: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath)
        cell.textLabel?.text = vm.type
        cell.detailTextLabel?.text = vm.size
        return cell
    }
}
