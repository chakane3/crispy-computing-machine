//
//  AppError.swift
//  crispy-computing-app
//
//  Created by Chakane Shegog on 10/10/21.
//

import Foundation


// Error handling against network request
// some errors could be network connection lost

enum AppError: Error {
    case badURL(String) // associated value
    case noResponse
    case networkClientError(Error)
    case noData
    case decodingError(Error)
    case badStatusCode(Int)
    case badMimeType(String)  // image/jpg
    
    
}
