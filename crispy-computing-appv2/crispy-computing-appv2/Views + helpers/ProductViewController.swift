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
    var products = [ammoData]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // TODO: implement search query
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadData()
        dump(res.getAmmo())

    }
    
    // MARK: - Actions and functions
    
    func loadData() {
        products = res.getAmmo()
    }
    
    // TODO:  implement sort by price method
    @IBAction func sortButtonPressed(_ sender: UIBarButtonItem) {
    }

}

// MARK: - Extensions: TableView
extension ProductViewController:  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    // create the ui for the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "productCell") as? CustomTableViewCell else {
            fatalError("check cell")
        }
        let product = products[indexPath.row]
        cell.configureCell(for: product)
        return cell
    }
}

extension ProductViewController: UITableViewDelegate {
    
    // set cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
