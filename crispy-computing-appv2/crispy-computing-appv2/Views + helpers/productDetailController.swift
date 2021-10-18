//
//  productDetailController.swift
//  crispy-computing-appv2
//
//  Created by Chakane Shegog on 10/18/21.
//

import UIKit

class productDetailController: UIViewController {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var caliberLabel: UILabel!
    
    var product: productData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        guard let prod = product else {
            fatalError("nil found, check prepare for segue")
        }
        nameLabel.text = prod.name
        priceLabel.text = "$\(prod.price)"
        linkLabel.text = prod.link
        caliberLabel.text = prod.caliber
        
        ImageClient.fetchImage(for: prod.imgURL) {
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
