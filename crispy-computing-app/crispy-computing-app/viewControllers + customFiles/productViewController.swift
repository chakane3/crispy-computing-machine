//
//  ViewController.swift
//  crispy-computing-app
//
//  Created by Chakane Shegog on 9/15/21.
//

import UIKit
import Foundation

enum gunType {
    case handgun
    case rifle
    case shotgun
}

enum searchScope {
    case name
    case caliber
}

class productViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private var sortAscending = true
    private var currentScope = searchScope.name
    
    // get data
    var products = [productData]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var searchQuery = "" {
        didSet {
            switch currentScope {
            case .name:
                products = CheaperThanDirtData.getHandgunProducts().filter {$0.name.lowercased().contains(searchQuery.lowercased())}
                
            case .caliber:
                products = CheaperThanDirtData.getHandgunProducts().filter {$0.caliber.lowercased().contains(searchQuery.lowercased())}
            }
        }
    }
    
    // set enum
    let aType = gunType.handgun
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        loadData()
        sortData(sortAscending)
    }
    
    func loadData() {
        switch aType {
            
        case .handgun:
            products = CheaperThanDirtData.getHandgunProducts()
            
        case .rifle:
            products = CheaperThanDirtData.getRifleProducts()
        
        case .shotgun:
            products = CheaperThanDirtData.getShotgunProducts()
        }
    }
    
    @IBAction func sortButtonPressed(_ sender: Any) {
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
    
    func filterHeadlines(for searchText: String) {
        guard !searchText.isEmpty else {return}
        products = CheaperThanDirtData.getHandgunProducts().filter {$0.name.lowercased().contains(searchText.lowercased())}
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let productDetailController = segue.destination as? productDetailViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError()
        }
        let product = products[indexPath.row]
        productDetailController.product = product
    }
}


// MARK: Extensions
extension productViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 225
    }
}

extension productViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // set up our custom cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as? customProductCell else {
            fatalError("couldent dequeue cell")
        }
        let product = products[indexPath.row]
        cell.configureCell(for: product)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
}

extension productViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // dismiss the keyboard
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            currentScope = .name
        case 1:
            currentScope = .caliber
            
        default:
            print("not a valid scope")
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            loadData()
            return
        }
        searchQuery = searchText
    }
    
    
    
}

