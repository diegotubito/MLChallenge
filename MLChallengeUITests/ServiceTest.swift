//
//  File.swift
//  MLChallengeTests
//
//  Created by David Diego Gomez on 17/09/2020.
//

import Foundation

import XCTest
@testable import MLChallenge

class MockService: ServiceManagerProtocol {
    func retrieveData(stringURL: String, completion: @escaping (Data?, ServiceError?) -> Void) {
        if shouldReturnError {
            completion(nil, ServiceError.decode)
        } else {
            completion(Data(), nil)
        }
    }
    
    var shouldReturnError = false
  
    func reset() {
        shouldReturnError = false
    }
  
}

class TestServiceManager: XCTestCase {
    let service = MockService()
    
    func testRetrieveData() {
        service.reset()
        service.shouldReturnError = false
        
        let expectation = self.expectation(description: "Espero recibir una respuesta de una llamada a API")
        service.shouldReturnError = false
        service.retrieveData(stringURL: "") { (data, error) in
            XCTAssertNil(error)
            guard data != nil else {
                XCTFail()
                return
            }
            
            expectation.fulfill()
        }
     
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
}
