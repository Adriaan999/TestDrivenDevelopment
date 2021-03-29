//
//  MockURLProtocol.swift
//  PhotoAppTests
//
//  Created by Adriaan van Schalkwyk on 2021/03/25.
//

import Foundation
@testable import PhotoApp

class MockURLProtocol: URLProtocol {
    
    static var stubResponseData: Data?
    static var error: Error?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        self.client?.urlProtocol(self, didLoad: MockURLProtocol.stubResponseData ?? Data())
        
        if let signupError = MockURLProtocol.error {
            self.client?.urlProtocol(self, didFailWithError: signupError)
        } else {
            self.client?.urlProtocolDidFinishLoading(self)
        }
    }
    
    override func stopLoading() {
    }
}
