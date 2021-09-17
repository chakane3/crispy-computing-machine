//
//  WebData.swift
//  crispy-computing-app
//
//  Created by Chakane Shegog on 9/16/21.
//

import Foundation

struct webData: Codable {
    let data: [ammo]
}

struct ammo: Codable {
    let caliber: String
//    var name =  [String]()
//    var price = [String]()
//    var link =  [String]()
}


extension webData {
    static func getProducts() -> [ammo] {
        var product = [ammo]()
        guard let fileUrl = Bundle.main.url(forResource: "CTDHandgun12", withExtension: "json") else {
            fatalError("check json name, or if it exists")
        }
        
        do {
            let data = try Data(contentsOf: fileUrl)
            let cData = try JSONDecoder().decode(webData.self, from: data)
            product = cData.data
        } catch {
            fatalError("data not found")
        }
        return product
    }
}
