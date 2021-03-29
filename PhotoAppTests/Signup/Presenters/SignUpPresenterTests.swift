//
//  SignUpPresenterTests.swift
//  PhotoAppTests
//
//  Created by Adriaan van Schalkwyk on 2021/03/25.
//

import XCTest
@testable import PhotoApp

class SignUpPresenterTests: XCTestCase {

    var signUpFromModel: SignUpFromModel!
    var mockSignUpModelValidator: MockSignUpModelValidator!
    var mockSignUpWebService: MockSignUpWebService!
    var mockSignUpViewDelegate: MockSignUpViewDelegate!

    var sut: SignUpPresenter!
    
    override func setUpWithError() throws {
        signUpFromModel = SignUpFromModel(firstName: "Sergey",
                                              lastName: "Kargoplov",
                                              email: "test@test.com",
                                              password: "12345678",
                                              repeatPassowrd: "12345678")
        mockSignUpModelValidator = MockSignUpModelValidator()
        mockSignUpWebService = MockSignUpWebService()
        mockSignUpViewDelegate = MockSignUpViewDelegate()
        sut = SignUpPresenter(formModelValidator: mockSignUpModelValidator,
                              webService: mockSignUpWebService,
                              delegate: mockSignUpViewDelegate)
    }

    override func tearDownWithError() throws {
        signUpFromModel = nil
        mockSignUpModelValidator = nil
        mockSignUpWebService = nil
        mockSignUpViewDelegate = nil
        sut = nil
        
    }
    
    func testSignUpPresenter_WhenInformationProvided_WillValidateEachProperty() {
        sut.proccessUserSignUp(fromModel: signUpFromModel)
        
        XCTAssertTrue(mockSignUpModelValidator.isFirstNameValidated)
        XCTAssertTrue(mockSignUpModelValidator.isLastNameValidated)
        XCTAssertTrue(mockSignUpModelValidator.isEmailValidated)
        XCTAssertTrue(mockSignUpModelValidator.isPasswordValidated)
        XCTAssertTrue(mockSignUpModelValidator.isPasswordRqualityValidated)
    }
    
    func testSignUpPresenter_WhenGiveValidFormModel_ShouldCallSignupMethod() {
        sut.proccessUserSignUp(fromModel: signUpFromModel)
        
        XCTAssertTrue(mockSignUpWebService.isSignUpMethodCalled)
    }
    
    func testSignUpPresenter_WhenSignUpOperationSuccessful_CallsSuccessOnViewDelegate() {
        let myExpection = expectation(description: "SuccessfulSignUp()")
        mockSignUpViewDelegate.expectation = myExpection
        sut.proccessUserSignUp(fromModel: signUpFromModel)
        XCTAssertEqual(mockSignUpViewDelegate.successfullSignUpCounter, 1)
        self.wait(for: [myExpection], timeout: 5)
    }
    
    func testSignUpPresenter_WhenSignUpOperationFails_ShouldCallErrorOnDelegate() {
        let myExpection = expectation(description: "error on SuccessfulSignUp()")
        mockSignUpViewDelegate.expectation = myExpection
        mockSignUpWebService.shouldReturnError = true
        
        sut.proccessUserSignUp(fromModel: signUpFromModel)
        self.wait(for: [myExpection], timeout: 5)

        XCTAssertEqual(mockSignUpViewDelegate.successfullSignUpCounter, 0)
        XCTAssertEqual(mockSignUpViewDelegate.errorCounter, 1)
        XCTAssertNotNil(mockSignUpViewDelegate.signupError)
    }
}
