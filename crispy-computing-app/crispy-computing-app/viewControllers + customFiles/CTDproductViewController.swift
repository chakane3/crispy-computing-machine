//
//  ViewController.swift
//  crispy-computing-app
//
//  Created by Chakane Shegog on 9/15/21.
//

import UIKit
import Foundation

enum CTDsearchScope {
    case name
    case caliber
}


class CTDproductViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private var sortAscending = true
    private var currentScope = CTDsearchScope.name
    
    // user selection
    var selected1: ammoOrArm?
    var selected2: gunType?
    
    // get data
    var products = [CTDproductData]() {
        didSet {
            tableView.reloadData()
        }
    }

 
    
    var searchQuery = "" {
        didSet {
            switch currentScope {
            case .name:
                
                switch selected2 {
                case .handgun:
                    products = CheaperThanDirtData.getHandgunProducts().filter {$0.name.lowercased().contains(searchQuery.lowercased())}
                    
                case .rifle:
                    products = CheaperThanDirtData.getRifleProducts().filter {$0.name.lowercased().contains(searchQuery.lowercased())}
                    
                case .shotgun:
                    products = CheaperThanDirtData.getShotgunProducts().filter {$0.name.lowercased().contains(searchQuery.lowercased())}
                    
                default:
                    print("no enum given")
                }
                
                
                
            case .caliber:
                products = CheaperThanDirtData.getHandgunProducts().filter {$0.caliber.lowercased().contains(searchQuery.lowercased())}
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
        print("passed enum: \(selected1!)")
        print("passed: enum: \(selected2!)")

    }
    
    func loadData() {
        
        switch selected2 {
        case .handgun:
            products = CheaperThanDirtData.getHandgunProducts()
            
        case .rifle:
            products = CheaperThanDirtData.getRifleProducts()
            
        case .shotgun:
            products = CheaperThanDirtData.getShotgunProducts()
            
        default:
            print("no enum was given")
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
        
        switch selected2 {
        case .handgun:
            products = CheaperThanDirtData.getHandgunProducts().filter {$0.name.lowercased().contains(searchText.lowercased())}
            
        case .rifle:
            products = CheaperThanDirtData.getRifleProducts().filter {$0.name.lowercased().contains(searchText.lowercased())}
        
        case .shotgun:
            products = CheaperThanDirtData.getShotgunProducts().filter {$0.name.lowercased().contains(searchText.lowercased())}
            
        default:
            print("no enum given")
        }
      
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let productDetailController = segue.destination as? CTDproductDetailViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError()
        }
        let product = products[indexPath.row]
        productDetailController.product = product
    }
}


// MARK: Extensions
extension CTDproductViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 225
    }
}


extension CTDproductViewController: UITableViewDataSource {
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

extension CTDproductViewController: UISearchBarDelegate {
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

