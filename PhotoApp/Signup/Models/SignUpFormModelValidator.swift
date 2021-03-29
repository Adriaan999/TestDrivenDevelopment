//
//  SignUpFormModelValidator.swift
//  PhotoApp
//
//  Created by Adriaan van Schalkwyk on 2021/03/24.
//

import Foundation

class SignUpFormModelValidator: SignUpModelValidatorProtocol {
    
    func isFirstNameValid(firstName: String) -> Bool {
        var returnValue = true
        if firstName.count < SignUpConstants.firstNameMinLength || firstName.count > SignUpConstants.firstNameMaxLength {
            returnValue = false
        }
        return returnValue
    }
    
    func isLastNameValid(lastName: String) -> Bool {
        var returnValue = true
        if lastName.count < SignUpConstants.lastNameMinLength || lastName.count > SignUpConstants.lastNameMaxLength {
            returnValue = false
        }
        return returnValue
    }
    
    func isEmailValid(email: String) -> Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: email)
    }
    
    func isPasswordValid(password: String) -> Bool {
        var returnValue = true
        if password.count < SignUpConstants.passwordMinLength || password.count > SignUpConstants.passwordMaxLength {
            returnValue = false
        }
        return returnValue
    }
    
    func passwordsMatch(password: String, repeatPassword: String) -> Bool {
        return password == repeatPassword
    }
}
