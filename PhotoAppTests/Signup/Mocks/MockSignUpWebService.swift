//
//  MockSignUpWebService.swift
//  PhotoAppTests
//
//  Created by Adriaan van Schalkwyk on 2021/03/25.
//

import Foundation
@testable import PhotoApp

class MockSignUpWebService: SignUpWebServiceProtocol {
    var isSignUpMethodCalled: Bool = false
    var shouldReturnError: Bool = false
    
    func signUp(withForm formModel: SignUpFormRequestModel,
                completion: @escaping (SignUpResponseModel?,
                                       SignUpErrors?) -> Void) {
        if shouldReturnError {
            completion(nil, SignUpErrors.failedRequest(description: "Signup request failed"))
        } else {
            isSignUpMethodCalled = true
            let responseModel = SignUpResponseModel(status: "ok")
            completion(responseModel, nil)
        }
    }
}
