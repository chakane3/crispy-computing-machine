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
    var searchQuery = "" {
        didSet {
            switch currentScope {
            case .name:
                products = ammoData.getAllAmmo().filter{$0.name.lowercased().contains(searchQuery.lowercased())}
                
            case .caliber:
                products = ammoData.getAllAmmo().filter{$0.caliber.lowercased().contains(searchQuery.lowercased())}
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
//        dump(ammoData.getAmmo())

    }
    
    // MARK: - Actions and functions
    
    func loadData() {
        switch userSelection1 {
        case .ammo:
            
            switch userSelection2 {
            case .searchAll:
                print("implement only \(userSelection2!) data")
                products = ammoData.getAllAmmo()
            case .handgun:
                print("implement only \(userSelection2!) data")
                products = ammoData.getAllAmmo().filter {$0.type.lowercased().contains("handgun")}
            case .rifle:
                print("implement \(userSelection2!) data")
                products = ammoData.getAllAmmo().filter {$0.type.lowercased().contains("rifle")}
            case .shotgun:
                print("implement \(userSelection2!) data")
                products = ammoData.getAllAmmo().filter {$0.type.lowercased().contains("shotgun")}
            default:
                print("no enum given 2")
            }
        case .arms:
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
        switch userSelection1 {
        case .ammo:
            switch userSelection2 {
            case .searchAll:
                print("implement search all filter")
                break
            case .handgun:
                print("implement handgun filter")
                break
            case .rifle:
                print("implement rifle filter")
                break
            case .shotgun:
                print("implement shotgun filter")
                break
            default:
                print("enum1")
            }
        default:
            print("enum2")
        }
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
