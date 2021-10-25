//
//  CustomTableViewCell.swift
//  crispy-computing-appv2
//
//  Created by Chakane Shegog on 10/13/21.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var caliberNameLabel: UILabel!
    @IBOutlet weak var gunTypeLabel: UILabel!
    
    func configureCell(for product: productData) {
        productNameLabel.text = product.name
        productPriceLabel.text = "$\(product.price)"
        caliberNameLabel.text = product.caliber
        gunTypeLabel.text = product.type
        
        // use closure to grab product photo
        productImage.setImage(with: product.imgURL) {(result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self.productImage.image = UIImage(systemName: "person fill")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self.productImage.image = image
                }
            }
        }
    }
}
