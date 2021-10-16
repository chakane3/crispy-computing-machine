//
//  ProductViewViewController.swift
//  crispy-computing-appv2
//
//  Created by Chakane Shegog on 10/13/21.
//

import UIKit

// scopes for our search bar filter
enum searchScope {
    case type
    case caliber
}

class ProductViewController: UIViewController {
    
    // MARK: -- outlets and properties
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // set our sort to true
    private var sortAscending = true
    
    // initialize enum
    private var currentScope = searchScope.type
    
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
    var searchQuery = "" {
        didSet {
            switch currentScope {
            case .type:
                products = ammoData.getAmmo().filter{$0.type.lowercased().contains(searchQuery.lowercased())}
                
            case .caliber:
                products = ammoData.getAmmo().filter{$0.caliber.lowercased().contains(searchQuery.lowercased())}
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        loadData()
        sortData(sortAscending)
        dump(ammoData.getAmmo())

    }
    
    // MARK: - Actions and functions
    
    func loadData() {
        products = ammoData.getAmmo()
    }
    
    // TODO:  implement sort by price method
    @IBAction func sortButtonPressed(_ sender: UIBarButtonItem) {
        sortAscending.toggle()
        sortData(sortAscending)
    }
    
    func sortData(_ sortAscending: Bool) {
        if sortAscending {
            products = products.sorted {Double($0.price) ?? 0  < Double($1.price) ?? 0}
            navigationItem.rightBarButtonItem?.title = "price high to low"
        } else {
            products = products.sorted {Double($0.price) ?? 0  > Double($1.price) ?? 0}
            navigationItem.rightBarButtonItem?.title = "price high to low"
        }
    }

    func filterProducts(for searchText: String) {
        guard !searchText.isEmpty else {return}
        products = ammoData.getAmmo().filter {$0.type.lowercased().contains(searchText.lowercased())}
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

// MARK: - Extensions Searchbar
extension ProductViewController: UISearchBarDelegate {
    
    // dismiss the keyboard
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            loadData()
            return
        }
        searchQuery = searchText
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            currentScope = .type
            break
        case 1: currentScope = .caliber
            break
        default:
            print("not a valid scope")
        }
    }
    
}
