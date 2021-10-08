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
    let ammo_results: [productData]
}

struct productData: Codable {
    let name: String
    var price: String
    let link: String
    let caliber: String
    let imgURL: String
}

extension CheaperThanDirtData {
    // functions to parse json data
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
    
    static func getHandgunProducts() -> [productData]{
        var caliberName = [productData]()
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
    
//    static func getSectionsByCaliber() -> [[productData]] {
//        print(aType)
//        let sortedCalibers =  getHandgunProducts().sorted {$0.caliber < $1.caliber}  // alphabetically sort caliber list
//        let caliberNames: Set<String> = Set(getHandgunProducts().map {$0.caliber})  // get unique values
//        var sectionsArr = Array(repeating: [productData](), count: caliberNames.count)
//
//        var currentIndex = 0
//        var currentCaliber = sortedCalibers.first?.caliber ?? "model error"
//
//        for productCaliber in sortedCalibers {
//            if productCaliber.caliber == currentCaliber {
//                sectionsArr[currentIndex].append(productCaliber)
//            } else {
//                currentIndex += 1
//                currentCaliber = productCaliber.caliber
//                sectionsArr[currentIndex].append(productCaliber)
//            }
//        }
//        return sectionsArr
//    }
}
