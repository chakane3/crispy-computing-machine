//
//  WebData.swift
//  crispy-computing-app
//
//  Created by Chakane Shegog on 9/16/21.
//

import Foundation
import UIKit

var aType = gunType?.self

struct CheaperThanDirtData: Codable {
    let type: String
    let ammo_results: [CTDproductData]
}

struct CTDproductData: Codable {
    let name: String
    var price: String
    let link: String
    let caliber: String
    let imgURL: String
}

extension CheaperThanDirtData {
    // functions to parse json data
    static func getRifleProducts() -> [CTDproductData] {
        var caliberName = [CTDproductData]()
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
    
    static func getHandgunProducts() -> [CTDproductData]{
        var caliberName = [CTDproductData]()
        guard let fileUrl = Bundle.main.url(forResource: "CTDHandgunAmmo", withExtension: "json") else {
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
    
    static func getShotgunProducts() -> [CTDproductData] {
        var caliberName = [CTDproductData]()
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
