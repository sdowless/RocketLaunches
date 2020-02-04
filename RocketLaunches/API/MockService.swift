//
//  MockService.swift
//  RocketLaunches
//
//  Created by Stephen Dowless on 2/3/20.
//  Copyright © 2020 Stephan Dowless. All rights reserved.
//

import Foundation

class MockService: Service {
    var session: URLSession!
    
    func getLaunchesWithMockSession(completion: @escaping(Result<[Launch], Error>) -> Void) {
        guard let url = self.url else { return }
                                        
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return 
            }

            guard let data = data else {
                let error = NSError(domain: "No data", code: 10, userInfo: nil)
                completion(.failure(error))
                return 
            }
            
            do {
                let launches = try JSONDecoder().decode(Launches.self, from: data)
                completion(.success(launches.launches))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}

class MockURLSession: URLSession {
    var cachedUrl: URL?
    let mockTask: MockTask
    
    init(data: Data?, response: URLResponse?, error: Error?) {
        mockTask = MockTask(data: data, urlResponse: response, error: error)
    }
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.cachedUrl = url
        self.mockTask.completionHandler = completionHandler
        return mockTask
    }
}


class MockTask: URLSessionDataTask {
    private let data: Data?
    private let urlResponse: URLResponse?
    private let mockError: Error?
    
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    
    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        self.data = data
        self.urlResponse = urlResponse
        self.mockError = error
    }
    
    override func resume() {
        DispatchQueue.main.async {
            self.completionHandler!(self.data, self.urlResponse, self.mockError)
        }
    }
}
