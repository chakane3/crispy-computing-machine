//
//  productDetailViewController.swift
//  crispy-computing-app
//
//  Created by Chakane Shegog on 10/3/21.
//

import UIKit

class CTDproductDetailViewController: UIViewController {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var caliberLabel: UILabel!
    @IBOutlet weak var linkLabel: UIButton!
    var product: CTDproductData?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        navigationItem.title = product?.name
        caliberLabel.text = product?.caliber
        
        
        // add image here
        ImageClient.fetchImage(for: product?.imgURL ?? "") {
            [unowned self] (result) in
            
            switch result {
            case .success((let image)):
                DispatchQueue.main.async {
                    self.productImage.image = image
                }
                
            case .failure(let error):
                print("configureCell image error - \(error)")
            }
        }
    }
}
