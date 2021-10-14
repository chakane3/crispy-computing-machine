//
//  ImageClient.swift
//  crispy-computing-appv2
//
//  Created by Chakane Shegog on 10/13/21.
//

import Foundation
import UIKit


struct ImageClient {
    // this function will take in a URL and use a "completion handler" to process the image and return it to us
    
    static func fetchImage(for urlString: String, completion: @escaping (Result<UIImage?, Error>) -> ()) {
        
        // create our url
        guard let url = URL(string: urlString) else {
            fatalError("bad url: \(urlString)")
        }
        
        let dataTask = URLSession.shared.dataTask(with:url) {
            (data, response, error) in
            
            if let error = error {
                print("error: \(error)")
            }
            
            if let data = data {
                let image = UIImage(data: data)
                completion(.success(image))
            }
        }
        dataTask.resume()
    }
}
