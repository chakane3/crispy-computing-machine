//
//  ammoData.swift
//  crispy-computing-appv2
//
//  Created by Chakane Shegog on 10/11/21.
//

import Foundation

struct res: Codable {
    let results: [ammoData]
}

struct ammoData: Codable {
    let type: String
    let ammo_results: [productData]
}

struct productData: Codable {
    let name: String
    let price: String
    let caliber: String
    let link: String
    let imgURL: String
}

extension res {
    // function to parse json data
    static func getAmmo() -> [ammoData] {
        
        // make an empty variable to hold our ammo data
        var p = [ammoData]()
        
        //get our file using App Bundle (access our in house resources)
        guard let fileURL = Bundle.main.url(forResource: "allAmmo", withExtension: "json") else {
            fatalError("check if json exists")
        }
        
        // access our json file using JSONDecoder
        do {
            let data = try Data(contentsOf: fileURL)
            let pData = try JSONDecoder().decode(res.self, from: data)
            p = pData.results
        } catch {
            fatalError("data not found \(error)")
        }
        return p
    }
}
