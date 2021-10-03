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

class productViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var sortAscending = true
    
    // get data
    var products = [productData]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // set enum
    let aType = gunType.handgun
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
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

