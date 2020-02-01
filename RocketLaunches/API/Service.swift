//
//  Service.swift
//  RocketLaunches
//
//  Created by Stephen Dowless on 1/30/20.
//  Copyright © 2020 Stephan Dowless. All rights reserved.
//

import UIKit
import Foundation

enum APIError: Error, CustomStringConvertible {
    case requestFailed
    case jsonParsingFailure
    case invalidData
    case responseUnsuccessful
    
    var description: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        }
    }
}

struct Service {
    static let shared = Service()
    
    private let launchCount = 20
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "launchlibrary.net"
        components.path = "/1.4/launch/next/\(launchCount)"
        return components.url
    }
    
    func fetchLaunches(completion: @escaping(Result<[Launch], Error>) -> Void) {
        guard let url = url else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            
           do {
                let launches = try decoder.decode(Launches.self, from: data)
                completion(.success(launches.launches))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchImage(withUrl url: URL, completion: @escaping(UIImage) -> Void) {
        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: url) else { return }
            guard let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}
