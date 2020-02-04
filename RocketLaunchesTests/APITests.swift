//
//  APITests.swift
//  RocketLaunchesTests
//
//  Created by Stephen Dowless on 2/3/20.
//  Copyright © 2020 Stephan Dowless. All rights reserved.
//

import XCTest
@testable import RocketLaunches

class APITests: XCTestCase {
    
    func testGetLaunchDataWithExpectedURLHostAndPath() {
        let mockService = MockService()
        let mockSession = MockURLSession(data: nil, response: nil, error: nil)
        mockService.session = mockSession
        
        mockService.getLaunchesWithMockSession { result in
            XCTAssertEqual(mockSession.cachedUrl?.host, "launchlibrary.net")
            XCTAssertEqual(mockSession.cachedUrl?.path, "/1.4/launch/next/20")
        }       
    }
    
    func testGetLaunchSuccess() {
        let mockService = MockService()
        let mockSession = MockURLSession(data: nil, response: nil, error: nil)
        mockService.session = mockSession

        let launchExpectation = expectation(description: "launches")
        var results: [Launch]?
        
        mockService.fetchLaunches { result in
            if case .success(let launches) = result {
                results = launches
                launchExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1) { error in
            XCTAssertNotNil(results)
        }
    }
    
    func testGetLaunchesErrorResponse() {
        let error = NSError(domain: "error", code: 1234, userInfo: nil)
        let mockURLSession = MockURLSession(data: nil, response: nil, error: error)

        let mockService = MockService()
        mockService.session = mockURLSession

        let errorExpectation = expectation(description: "error")
        var errorResponse: Error?

        mockService.getLaunchesWithMockSession { result in
            if case .failure(let error) = result {
                errorExpectation.fulfill()
                errorResponse = error
            }
        }

        waitForExpectations(timeout: 1) { error in
            XCTAssertNotNil(errorResponse)
        }
    }
    
    func testGetLaunchesWithEmptyData() {
        let mockURLSession = MockURLSession(data: nil, response: nil, error: nil)
        let mockService = MockService()
        mockService.session = mockURLSession
        
        let errorExpectation = expectation(description: "error")
        var errorResponse: Error?
        
        mockService.getLaunchesWithMockSession { result in
            if case .failure(let error) = result {
                errorExpectation.fulfill()
                errorResponse = error
            }
        }
        
        waitForExpectations(timeout: 1) { error in
            XCTAssertNotNil(errorResponse)
        }
    }
    
    func testGetLaunchesWithInvalidJSON() {
        let jsonData = "[{\"bad data\"}]".data(using: .utf8)
        let mockURLSession = MockURLSession(data: jsonData, response: nil, error: nil)
        let mockService = MockService()
        mockService.session = mockURLSession
        
        let errorExpectation = expectation(description: "error")
        var errorResponse: Error?
        
        mockService.getLaunchesWithMockSession { result in
            if case .failure(let error) = result {
                errorExpectation.fulfill()
                errorResponse = error
            }
        }
        
        waitForExpectations(timeout: 1) { error in
            XCTAssertNotNil(errorResponse)
        }
    }
    
    func testGetLaunchImageSuccess() {
        let mockURLSession = MockURLSession(data: nil, response: nil, error: nil)
        let mockService = MockService()
        mockService.session = mockURLSession
        
        var imageResult: UIImage?
        let imageExpectation = expectation(description: "image")
        
        let imageUrl = "https://s3.amazonaws.com/launchlibrary/RocketImages/placeholder_1920.png"
        
        mockService.getImageWithMockSession(withUrl: imageUrl) { result in
            if case .success(let image) = result {
                imageResult = image
                imageExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1) { error in
            XCTAssertNotNil(imageResult)
        }
    }
    
    func testGetLaunchImageInvalidURL() {
        let mockURLSession = MockURLSession(data: nil, response: nil, error: nil)
        let mockService = MockService()
        mockService.session = mockURLSession
        
        let errorExpectation = expectation(description: "error")
        var errorResponse: Error?
        
        let imageUrl = "invalidUrl"
        
        mockService.getImageWithMockSession(withUrl: imageUrl) { result in
            if case .failure(let error) = result {
                errorExpectation.fulfill()
                errorResponse = error
            }
        }
        
        waitForExpectations(timeout: 1) { error in
            XCTAssertNotNil(errorResponse)
        }

    }
}
