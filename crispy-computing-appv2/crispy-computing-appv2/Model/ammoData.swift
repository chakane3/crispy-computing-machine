//
//  ammoData.swift
//  crispy-computing-appv2
//
//  Created by Chakane Shegog on 10/11/21.
//

import Foundation

struct ammoData: Codable {
    let type: String
    let ammo_results: [productData]
}

struct productData: Codable {
    let name: String
    let price: String
    let link: String
    let caliber: String
    let imgURL: String
}

extension ammoData {
    // function to parse json data
    static func getAmmo() -> String {
        
        // make an empty variable to hold our ammo data
        var p = String()
        
        //get our file using App Bundle (access our in house resources)
        guard let fileURL = Bundle.main.url(forResource: "allAmmo", withExtension: "json") else {
            fatalError("check if json exists")
        }
        
        // access our json file using JSONDecoder
        do {
            let data = try Data(contentsOf: fileURL)
            let pData = try JSONDecoder().decode(ammoData.self, from: data)
            p = pData.type
        } catch {
            fatalError("data not found")
        }
        return p
    }
}
