//
//  SignUpFormRequestModel.swift
//  PhotoApp
//
//  Created by Adriaan van Schalkwyk on 2021/03/25.
//

import Foundation

struct SignUpFormRequestModel: Encodable {
    var firstName: String
    var lastName: String
    var email: String
    var password: String
}
