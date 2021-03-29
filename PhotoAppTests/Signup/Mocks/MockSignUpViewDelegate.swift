//
//  MockSignUpViewDelegate.swift
//  PhotoAppTests
//
//  Created by Adriaan van Schalkwyk on 2021/03/25.
//

import Foundation
import XCTest
@testable import PhotoApp

class MockSignUpViewDelegate: SignUpViewDelegateProtocol {
    
    var expectation: XCTestExpectation?
    var successfullSignUpCounter = 0
    var errorCounter = 0
    var signupError: SignUpErrors?
    
    func successfullSignUp() {
        successfullSignUpCounter += 1
        expectation?.fulfill()
    }
    
    func errorHandler(error: SignUpErrors) {
        signupError = error
        errorCounter += 1
        expectation?.fulfill()
    }
}
