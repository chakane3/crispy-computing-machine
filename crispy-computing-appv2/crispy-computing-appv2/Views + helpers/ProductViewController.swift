//
//  ProductViewViewController.swift
//  crispy-computing-appv2
//
//  Created by Chakane Shegog on 10/13/21.
//

import UIKit

// scopes for our search bar filter
enum searchScope {
    case name
    case caliber
}

class ProductViewController: UIViewController {
    
    // MARK: -- outlets and properties
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // set our sort to true
    private var sortAscending = true
    
    // initialize enum
    private var currentScope = searchScope.name
    
    // initialize enum for user product selection
    var userSelection1: ammoOrArmsState?
    var userSelection2: gunTypeState?
    
    // get product data
    var products = [productData]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // TODO: implement search query
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    // MARK: - Actions and functions
    
    func loadData() {
        products = result.getAmmo()
    }
    
    @IBAction func sortButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    
    func sortData(_ sortAscending: Bool) {
        if sortAscending {
            products = products.sorted {$0.ammo_results["price"] < $1.ammo_results["price"] }
            
        }
    
    }
    
    
    
    
    
}
