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
    
    func configureCell(for product: productData) {
        productNameLabel.text = product.price
        productPriceLabel.text = product.price
        caliberNameLabel.text = product.caliber
        
        // use ImageClient to grab product photo
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
