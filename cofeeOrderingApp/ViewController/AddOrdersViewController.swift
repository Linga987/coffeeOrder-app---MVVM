//
//  AddOrdersViewController.swift
//  cofeeOrderingApp
//
//  Created by karingula Lingaswami on 29/03/24.
//

import Foundation
import UIKit

protocol AddCoffeeOrderDelegate {
    func addCoffeeOrderViewCOntrollerDidSave(oreder: Order, controller: UIViewController)
    func addOrdersViewControllerDidClose(controller: UIViewController)
}

class AddOrdersViewController: UIViewController {
    
    var delegate: AddCoffeeOrderDelegate?
    var addCoffeeViewModel = AddCoffeeOrderViewModel()
    private var cofeeSizeSegmentedCotroller: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        self.cofeeSizeSegmentedCotroller = UISegmentedControl(items: self.addCoffeeViewModel.size)
        self.cofeeSizeSegmentedCotroller.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.cofeeSizeSegmentedCotroller)
        self.cofeeSizeSegmentedCotroller.topAnchor.constraint(equalTo: self.tableView.topAnchor, constant: 380).isActive = true
        self.cofeeSizeSegmentedCotroller.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        let name = self.nameTextField.text
        let email = self.emailTextField.text
        
        let selectedSize = self.cofeeSizeSegmentedCotroller.titleForSegment(at: cofeeSizeSegmentedCotroller.selectedSegmentIndex)
        guard let indexPath = self.tableView.indexPathForSelectedRow else {
            fatalError("Error in selecting cofee!")
        }
        
        addCoffeeViewModel.name = name
        addCoffeeViewModel.email = email
        addCoffeeViewModel.selectedSize = selectedSize
        addCoffeeViewModel.selectedType = self.addCoffeeViewModel.type[indexPath.row]
        
        WebService().load(resource: Order.create(self.addCoffeeViewModel)) { result in
            switch result {
            case .success(let order):
              if let order = order, let delegate = self.delegate {
                  DispatchQueue.main.async {
                      delegate.addCoffeeOrderViewCOntrollerDidSave(oreder: order, controller: self)
                  }
                }
            case.failure(let error):
                print(error)
            }
        }
        
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        if let delegate = self.delegate {
            delegate.addOrdersViewControllerDidClose(controller: self)
        }
    }
    
    
}

extension AddOrdersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addCoffeeViewModel.type.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddTableViewCell", for: indexPath)
        cell.textLabel?.text = addCoffeeViewModel.type[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
}
