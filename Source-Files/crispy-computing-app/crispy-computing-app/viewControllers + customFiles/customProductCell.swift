//
//  customProductCell.swift
//  crispy-computing-app
//
//  Created by Chakane Shegog on 9/27/21.
//

import UIKit

class customProductCell: UITableViewCell {
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!

    @IBOutlet weak var caliberNameLabel: UILabel!
    
    func configureCell(for product: CTDproductData) {
        productNameLabel.text = product.name
        productPriceLabel.text = "$\(product.price)"
        caliberNameLabel.text = product.caliber
        
        // TODO: add image here
        ImageClient.fetchImage(for: product.imgURL) {
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
