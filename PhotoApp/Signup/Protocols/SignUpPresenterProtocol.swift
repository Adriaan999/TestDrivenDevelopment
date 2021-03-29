//
//  SignUpPresenterProtocol.swift
//  PhotoApp
//
//  Created by Adriaan van Schalkwyk on 2021/03/26.
//

import Foundation

protocol SignUpPresenterProtocol: AnyObject {
    
    init(formModelValidator: SignUpModelValidatorProtocol,
         webService: SignUpWebServiceProtocol,
         delegate: SignUpViewDelegateProtocol)
    func proccessUserSignUp(fromModel: SignUpFromModel)
}
