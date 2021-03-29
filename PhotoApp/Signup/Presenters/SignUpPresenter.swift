//
//  SignUpPresenter.swift
//  PhotoApp
//
//  Created by Adriaan van Schalkwyk on 2021/03/25.
//

import Foundation

class SignUpPresenter: SignUpPresenterProtocol {
    
    private var formModelValidator: SignUpModelValidatorProtocol
    private var webService: SignUpWebServiceProtocol
    private weak var delegate: SignUpViewDelegateProtocol?
    
    required init(formModelValidator: SignUpModelValidatorProtocol,
         webService: SignUpWebServiceProtocol,
         delegate: SignUpViewDelegateProtocol) {
        self.formModelValidator = formModelValidator
        self.webService = webService
        self.delegate = delegate
    }
    
    func proccessUserSignUp(fromModel: SignUpFromModel) {
        if !formModelValidator.isFirstNameValid(firstName: fromModel.firstName) {
            return
        }
        
        if !formModelValidator.isLastNameValid(lastName: fromModel.lastName) {
            return
        }
        
        if !formModelValidator.isEmailValid(email: fromModel.email){
            return
        }
        
        if !formModelValidator.isPasswordValid(password: fromModel.password) {
            return
        }
        
        if !formModelValidator.passwordsMatch(password: fromModel.password, repeatPassword: fromModel.repeatPassowrd) {
            return
        }
        
        let requestModel = SignUpFormRequestModel(firstName: fromModel.firstName, lastName: fromModel.lastName, email: fromModel.email, password: fromModel.password)
        webService.signUp(withForm: requestModel) { [weak self] (responsModel, error) in
            
            if let error = error {
                self?.delegate?.errorHandler(error: error)
                return
            }
            
            if let _ = responsModel {
                self?.delegate?.successfullSignUp()
                return
            }
        }
    }
}
