//
//  MockSignUpPresenter.swift
//  PhotoAppTests
//
//  Created by Adriaan van Schalkwyk on 2021/03/26.
//

import Foundation
@testable import PhotoApp

class MockSignUpPresenter: SignUpPresenterProtocol {
    
    var proccessUserSignUpCalled: Bool = false
    
    required init(formModelValidator: SignUpModelValidatorProtocol, webService: SignUpWebServiceProtocol, delegate: SignUpViewDelegateProtocol) {
        
    }
    
    func proccessUserSignUp(fromModel: SignUpFromModel) {
        proccessUserSignUpCalled = true
    }
    
}

