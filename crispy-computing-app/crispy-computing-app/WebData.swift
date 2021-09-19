//
//  WebData.swift
//  crispy-computing-app
//
//  Created by Chakane Shegog on 9/16/21.
//

import Foundation


struct webData: Codable {
    let caliber: String
}

extension webData {
    // this could be looped for all other json files
    static func getProducts() -> String {
        var product: String
        guard let fileUrl = Bundle.main.url(forResource: "CTDHandgunAmmo12", withExtension: "json") else {
            fatalError("check json name, or if it exists")
        }
        print("fileUrl: \(fileUrl)")
        
        do {
            let data = try Data(contentsOf: fileUrl)
            let productData = try JSONDecoder().decode(webData.self, from: data)
            product = productData.caliber
        } catch {
            fatalError("data not found")
        }
        return product
    }
}
