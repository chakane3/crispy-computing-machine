//
//  AppError.swift
//  crispy-computing-appv2
//
//  Created by Chakane Shegog on 10/24/21.
//

import Foundation



enum AppError: Error {
    case badURL(String)
    case noResponse
    case networkClientError(Error)
    case noData
    case decodingError(Error)
    case badstatuscode(Int)
    case badMimeType(String)
}
