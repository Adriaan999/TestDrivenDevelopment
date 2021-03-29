//
//  SignUpWebServiceProtocol.swift
//  PhotoApp
//
//  Created by Adriaan van Schalkwyk on 2021/03/25.
//

import Foundation

protocol SignUpWebServiceProtocol {
    func signUp(withForm formModel: SignUpFormRequestModel,
                completion: @escaping (SignUpResponseModel?,
                                       SignUpErrors?) -> Void)
}
