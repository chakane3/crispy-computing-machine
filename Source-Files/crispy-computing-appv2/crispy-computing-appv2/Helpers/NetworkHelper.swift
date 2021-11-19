//
//  NetworkHelper.swift
//  crispy-computing-appv2
//
//  Created by Chakane Shegog on 10/24/21.
//

import Foundation

class NetworkHelper {
    static let shared =  NetworkHelper()
    private var session: URLSession
    private init() {
        session = URLSession(configuration: .default)
    }
    
    func performDataTask(with request: URLRequest, completion: @escaping (Result<Data, AppError>) -> ()) {
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.networkClientError(error)))
            }
            
            guard let urlResponse = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            switch urlResponse.statusCode {
            case 200...299: break
            default:
                completion(.failure(.badstatuscode(urlResponse.statusCode)))
                return
            }
            completion(.success(data))
        }
        dataTask.resume()
    }
}
