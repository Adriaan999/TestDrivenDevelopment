//
//  SignUpViewDelegateProtocol.swift
//  PhotoApp
//
//  Created by Adriaan van Schalkwyk on 2021/03/25.
//

import Foundation

protocol SignUpViewDelegateProtocol: AnyObject {
    func successfullSignUp()
    func errorHandler(error: SignUpErrors)
}
