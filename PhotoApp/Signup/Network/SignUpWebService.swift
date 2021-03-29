//
//  SignUpWebService.swift
//  PhotoApp
//
//  Created by Adriaan van Schalkwyk on 2021/03/25.
//

import Foundation

class SignUpWebService: SignUpWebServiceProtocol {
    
    private var urlString: String
    private var urlSession: URLSession
    
    init(urlString: String,
         urlSession: URLSession = .shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    func signUp(withForm formModel: SignUpFormRequestModel,
                completion: @escaping (SignUpResponseModel?, SignUpErrors?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil, SignUpErrors.invalidRequestURLStringError)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(formModel)
        
        let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
            if let requestError = error {
                completion(nil, SignUpErrors.failedRequest(description: requestError.localizedDescription))
                return
            }
            
            if let data = data,
               let signUpResponseModel = try? JSONDecoder().decode(SignUpResponseModel.self, from: data) {
                completion(signUpResponseModel, nil)
            } else {
                completion(nil, SignUpErrors.responseModelParsingError)
            }
        }
        dataTask.resume()
    }
}
