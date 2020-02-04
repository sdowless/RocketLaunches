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

class Service {
    static let shared = Service()
    
    private let launchCount = 20
    var url: URL? { return _url }
    
    private var _url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "launchlibrary.net"
        components.path = "/1.4/launch/next/\(launchCount)"
        return components.url
    }
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()
    
    func fetchLaunches(completion: @escaping(Result<[Launch], Error>) -> Void) {
        guard let url = _url else { return }
                
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let launches = try self.decoder.decode(Launches.self, from: data)
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


