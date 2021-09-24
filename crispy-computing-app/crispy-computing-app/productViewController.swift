//
//  ViewController.swift
//  crispy-computing-app
//
//  Created by Chakane Shegog on 9/15/21.
//

import UIKit

class productViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let productData = webData.getProducts()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        dump(webData.getProducts())
//        dump(webData.getCaliberName())
        
        // Do any additional setup after loading the view.
    }
    
    
}

extension productViewController: UITableViewDelegate {}
extension productViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)
        let product = productData[indexPath.row]
        print(product)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productData.count
    }
}

