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
    var userSelection1: Int?
    var userSelection2: Int?
    
    // get product data
    var products = [productData]() {
        didSet {
            tableView.reloadData()
        }
    }

    
    var searchQuery = "" {
        didSet {
            switch currentScope {
            case .name:
                switch userSelection2 {
                case 3:
                    products = ammoData.getAllAmmo().filter {$0.name.lowercased().contains(searchQuery.lowercased())}
                case 4:
                    let filterProd = ammoData.getAllAmmo().filter {$0.type.lowercased().contains("handgun")}
                    products = filterProd.filter {$0.name.lowercased().contains(searchQuery.lowercased())}
                case 5:
                    let filterProd = ammoData.getAllAmmo().filter {$0.type.lowercased().contains("rifle")}
                    products = filterProd.filter {$0.name.lowercased().contains(searchQuery.lowercased())}
                case 6:
                    let filterProd = ammoData.getAllAmmo().filter {$0.type.lowercased().contains("shotgun")}
                    products = filterProd.filter {$0.name.lowercased().contains(searchQuery.lowercased())}
                default:
                    print("check selection process")
                }

           
            case .caliber:
                switch userSelection2 {
                case 3:
                    products = ammoData.getAllAmmo().filter {$0.caliber.lowercased().contains(searchQuery.lowercased())}
                case 4:
                    let filterProd = ammoData.getAllAmmo().filter {$0.type.lowercased().contains("handgun")}
                    products = filterProd.filter {$0.caliber.lowercased().contains(searchQuery.lowercased())}
                case 5:
                    let filterProd = ammoData.getAllAmmo().filter {$0.type.lowercased().contains("rifle")}
                    products = filterProd.filter {$0.caliber.lowercased().contains(searchQuery.lowercased())}
                case 6:
                    let filterProd = ammoData.getAllAmmo().filter {$0.type.lowercased().contains("shotgun")}
                    products = filterProd.filter {$0.caliber.lowercased().contains(searchQuery.lowercased())}
                default:
                    print("check selection process")
                }
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
    }
    
    // MARK: - Actions and functions
    
    func loadData() {
        switch userSelection1 {
        case 0:
            switch userSelection2 {
            case 3:
                products = ammoData.getAllAmmo()
            case 4:
                products = ammoData.getAllAmmo().filter {$0.type.lowercased().contains("handgun")}
            case 5:
                products = ammoData.getAllAmmo().filter {$0.type.lowercased().contains("rifle")}
            case 6:
                products = ammoData.getAllAmmo().filter {$0.type.lowercased().contains("shotgun")}

            default:
                print("no enum given 2")
            }
        case 1:
            print("not a feature :(")
            
        default:
            print("no enum given 1")
        }
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
            navigationItem.rightBarButtonItem?.title = "price low to high"
        }
    }

    func filterProducts(for searchText: String) {
        guard !searchText.isEmpty else {return}
        switch userSelection2 {
        case 3:
            products = ammoData.getAllAmmo().filter {$0.name.lowercased().contains(searchText.lowercased())}
            
        case 4:
            products = ammoData.getAllAmmo().filter {$0.type.lowercased().contains("handgun")}
            products = products.filter {$0.name.lowercased().contains(searchText.lowercased())}
            
        case 5:
            products = ammoData.getAllAmmo().filter {$0.type.lowercased().contains("rifle")}
            products = products.filter {$0.name.lowercased().contains(searchText.lowercased())}
        
        case 6:
            products = ammoData.getAllAmmo().filter {$0.type.lowercased().contains("shotgun")}
            products = products.filter {$0.name.lowercased().contains(searchText.lowercased())}
        default:
            print("PVC - filter product error")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let pVC = segue.destination as? productDetailController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("could not retrieve an instance of product detail controller, verify class name in identity inspector")
        }
        let product = products[indexPath.row]
        pVC.product = product
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
        return 250
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
            currentScope = .name
            break
        case 1: currentScope = .caliber
            break
        default:
            print("not a valid scope")
        }
    }
    
}
