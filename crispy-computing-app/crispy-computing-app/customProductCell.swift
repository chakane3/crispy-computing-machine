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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // change the corner radius here
        productImage.layer.cornerRadius = 4
    }
    
    func configureCell(for product: productData) {
        productNameLabel.text = product.name
        productPriceLabel.text = product.price
        
        // TODO: add image here
    }
    
}
