//
//  LuckyGunnerData.swift
//  crispy-computing-app
//
//  Created by Chakane Shegog on 10/10/21.
//

import Foundation

struct LuckyGunnerData: Codable {
    let type: String
    let ammo_results: [LGproductData]
}

struct LGproductData: Codable {
    let name: String
    let prices: String
    let links: String
    let caliber: String
    let imgUrl: String
}

extension LuckyGunnerData {
    static func getHandgunProducts() -> [LGproductData] {
        var product = [LGproductData]()
        guard let fileUrl = Bundle.main.url(forResource: "LGHandgunAmmo", withExtension: "json") else {
            fatalError("check is json exists/name error")
        }
        do {
            let data = try Data(contentsOf: fileUrl)
            let pData = try JSONDecoder().decode(LuckyGunnerData.self, from: data)
            product = pData.ammo_results
        } catch {
            fatalError("data not found")
        }
        return product
    }
}
