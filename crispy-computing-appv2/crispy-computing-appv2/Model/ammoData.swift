//
//  ammoData.swift
//  crispy-computing-appv2
//
//  Created by Chakane Shegog on 10/11/21.
//

import Foundation

struct ammoData: Codable {
    let ammo_results: [productData]
}

struct productData: Codable {
    let name: String
    let price: String
    let caliber: String
    let link: String
    let imgURL: String
}

extension ammoData {
    // function to parse json data
    static func getAmmo() -> [productData] {
        
        // make an empty variable to hold our ammo data
        var p = [productData]()
        
        //get our file using App Bundle (access our in house resources)
        guard let fileURL = Bundle.main.url(forResource: "allAmmo", withExtension: "json") else {
            fatalError("check if json exists")
        }
        
        // access our json file using JSONDecoder
        do {
            let data = try Data(contentsOf: fileURL)
            let pData = try JSONDecoder().decode(ammoData.self, from: data)
            p = pData.ammo_results
        } catch {
            fatalError("data not found \(error)")
        }
        return p
    }
}
