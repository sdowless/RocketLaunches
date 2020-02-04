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
    case networkError
    case serverError
    case jsonParsingFailure
    case invalidData
    case clientError(Error)
    
    var description: String {
        switch self {
        case .networkError: return "Unable to establish a network connection"
        case .serverError: return "Unable to retrieve data from the server"
        case .invalidData: return "The data received from the server is not valid"
        case .clientError(let error): return "Something went wrong: \(error.localizedDescription)"
        case .jsonParsingFailure: return "Unable to process the incoming data from the server"
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
    
    func fetchLaunches(completion: @escaping(Result<[Launch], APIError>) -> Void) {
        guard let url = _url else { return }
                
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.networkError))
                return
            }
            
            if response.statusCode != 200 {
                completion(.failure(.serverError))
            }
            
            if let error = error {
                completion(.failure(.clientError(error)))
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let launches = try self.decoder.decode(Launches.self, from: data)
                completion(.success(launches.launches))
            } catch {
                completion(.failure(.jsonParsingFailure))
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


