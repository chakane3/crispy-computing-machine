//
//  WebData.swift
//  crispy-computing-app
//
//  Created by Chakane Shegog on 9/16/21.
//

import Foundation


struct CheaperThanDirtData: Codable {
    let type: String
    let ammo_results: [productData]
}

struct productData: Codable {
    let name: String
    let price: String
    let link: String
    let caliber: String
    let imgUrl: String
}

extension CheaperThanDirtData {
    // this could be looped for all other json files
    static func getRifleProducts() -> [productData] {
        var caliberName = [productData]()
        guard let fileUrl = Bundle.main.url(forResource: "CTDRifleAmmo", withExtension: "json") else {
            fatalError("check json name, or if it exists")
        }
        do {
            let data = try Data(contentsOf: fileUrl)
            let pData = try JSONDecoder().decode(CheaperThanDirtData.self, from: data)
            caliberName = pData.ammo_results
        } catch {
            fatalError("data not found")
        }
        return caliberName
    }
    
    static func getHandgunProducts() -> [productData] {
        var caliberName = [productData]()
        guard let fileUrl = Bundle.main.url(forResource: "CTDShotgunAmmo", withExtension: "json") else {
            fatalError("check json name, or if it exists")
        }
        do {
            let data = try Data(contentsOf: fileUrl)
            let pData = try JSONDecoder().decode(CheaperThanDirtData.self, from: data)
            caliberName = pData.ammo_results
        } catch {
            fatalError("data not found")
        }
        return caliberName
    }
    
    static func getShotgunProducts() -> [productData] {
        var caliberName = [productData]()
        guard let fileUrl = Bundle.main.url(forResource: "CTDShotgunAmmo", withExtension: "json") else {
            fatalError("check json name, or if it exists")
        }
        do {
            let data = try Data(contentsOf: fileUrl)
            let pData = try JSONDecoder().decode(CheaperThanDirtData.self, from: data)
            caliberName = pData.ammo_results
        } catch {
            fatalError("data not found")
        }
        return caliberName
    }
    

}
