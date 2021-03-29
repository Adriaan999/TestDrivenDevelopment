//
//  SignUpWebServiceTest.swift
//  PhotoAppTests
//
//  Created by Adriaan van Schalkwyk on 2021/03/25.
//

import XCTest
@testable import PhotoApp

class SignUpWebServiceTest: XCTestCase {
    
    var sut: SignUpWebService!
    var signUpFormRequestModel: SignUpFormRequestModel!
    
    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        sut = SignUpWebService(urlString: SignUpConstants.signupURLString, urlSession: urlSession)
        signUpFormRequestModel = SignUpFormRequestModel(firstName: "Sergey",
                                                        lastName: "Kargoplov",
                                                        email: "test@test.com",
                                                        password: "12345678")
    }
    
    override func tearDownWithError() throws {
        sut = nil
        signUpFormRequestModel = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
    }
    
    func testSignUpWebservice_WhenGivenSuccessfullResponse_ReturnsSuccess() {
        let jsonString = "{\"status\":\"ok\"}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        let expectation = self.expectation(description: "Signup Web Service Response Expectation")
        sut.signUp(withForm: signUpFormRequestModel) { (signUpResponseModel, error) in
            XCTAssertEqual(signUpResponseModel?.status, "ok")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testSignUpWebservice_whenReceivedDifferentJSONResponse_ErrorTookPlace() {
        let jsonString = "{\"path\":\"/users\", \"error\":\"Internal Server Error\"}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        let expectation = self.expectation(description: "Signup Web Service Response Expectation")
        sut.signUp(withForm: signUpFormRequestModel) { (signUpResponseModel, error) in
            XCTAssertNil(signUpResponseModel)
            XCTAssertEqual(error, SignUpErrors.responseModelParsingError)
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testSignUpWebservice_WhenEmptyURLStringProvided_ReturnsError() {
        let expectation = self.expectation(description: "An empty request URL Expectation")
        sut = SignUpWebService(urlString: "")
        sut.signUp(withForm: signUpFormRequestModel) { (signUpResponseModel, error) in
            XCTAssertEqual(error, SignUpErrors.invalidRequestURLStringError)
            XCTAssertNil(signUpResponseModel)
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2)
    }
    
    func testSignUpWebservice_WhenURLRequestFails_ReturnsErrorMessage() {
        let expectation = self.expectation(description: "A failed request Expectation")
        let errorDescription = "A localized description of an error"
        MockURLProtocol.error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorDescription])
        sut.signUp(withForm: signUpFormRequestModel) { (signUpResponseModel, error) in
            XCTAssertEqual(error, SignUpErrors.failedRequest(description: errorDescription))
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2)
    }
}
