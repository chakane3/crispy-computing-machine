//
//  WebData.swift
//  crispy-computing-app
//
//  Created by Chakane Shegog on 9/16/21.
//

import Foundation


struct webData: Codable {
    let caliber: String
    let name: Array<String>
    let price: Array<String>
    let link: Array<String>
}

extension webData {
    // this could be looped for all other json files
    static func getCaliberName() -> String {
        var caliberName: String
        guard let fileUrl = Bundle.main.url(forResource: "CTDHandgunAmmo12", withExtension: "json") else {
            fatalError("check json name, or if it exists")
        }

        
        do {
            let data = try Data(contentsOf: fileUrl)
            let productData = try JSONDecoder().decode(webData.self, from: data)
            caliberName = productData.caliber
        } catch {
            fatalError("data not found")
        }
        return caliberName
    }
    
    
    static func getProducts() -> [Array<String>] {
        
        var productName: Array<String>
        var productPrice: Array<String>
        var productLink: Array<String>
        guard let fileUrl = Bundle.main.url(forResource: "CTDHandgunAmmo12", withExtension: "json") else {
            fatalError("check json name, or if it exists")
        }
        
        do {
            let data = try Data(contentsOf: fileUrl)
            let productData = try JSONDecoder().decode(webData.self, from: data)
            productName = productData.name
            productPrice = productData.price
            productLink = productData.link
        } catch {
            fatalError("data not found")
        }
        return [productName, productPrice, productLink]
    }
}
