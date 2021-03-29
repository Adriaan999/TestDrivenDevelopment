//
//  SignUpVIewControllerTests.swift
//  PhotoAppTests
//
//  Created by Adriaan van Schalkwyk on 2021/03/26.
//

import XCTest
@testable import PhotoApp

class SignUpVIewControllerTests: XCTestCase {

    var storyBoard: UIStoryboard!
    var sut: SignUpViewController!
        
    override func setUpWithError() throws {
        storyBoard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyBoard.instantiateViewController(identifier: "SignUpViewController") as SignUpViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        storyBoard = nil
        sut = nil
    }
    
    func testSignUpViewController_WhenCreated_HasRequiredTextFieldsEmpty() throws {
        let firstNameTextField = try XCTUnwrap(sut.userFirstNameTextField, "Not connected to IBOutlet")
        let lastNameTextField = try XCTUnwrap(sut.lastNameTextField, "Not connected to IBOutlet")
        let emailTextField = try XCTUnwrap(sut.emailTextField, "Not connected to IBOutlet")
        let passwordTextField = try XCTUnwrap(sut.passwordTextField, "Not connected to IBOutlet")
        let repeatPasswordTextField = try XCTUnwrap(sut.repeatPasswordTextField, "Not connected to IBOutlet")
        XCTAssertEqual(firstNameTextField.text, "")
        XCTAssertEqual(lastNameTextField.text, "")
        XCTAssertEqual(emailTextField.text, "")
        XCTAssertEqual(passwordTextField.text, "")
        XCTAssertEqual(repeatPasswordTextField.text, "")
    }
    
    func testSignUpViewController_WhenCreated_HasSignUpButtonAndAction() throws {
        let signUpButton: UIButton = try XCTUnwrap(sut.signUpButton, "Not connected to IBOutlet")
        let signUpButtonActions = try XCTUnwrap(signUpButton.actions(forTarget: sut, forControlEvent: .touchUpInside))
        
        XCTAssertEqual(signUpButtonActions.count, 1)
        XCTAssertEqual(signUpButtonActions.first, "signUpButtonPressed:")
    }
    
    func testSignUpViewController_WhenSignUpButtonPressed_InvokesSignUpPressed() {
        let mockSignUpModelValidator = MockSignUpModelValidator()
        let mockSignUpWebservice = MockSignUpWebService()
        let mockSignUpDelegate = MockSignUpViewDelegate()
        let mockSignUpPresenter = MockSignUpPresenter(formModelValidator: mockSignUpModelValidator,
                                                      webService: mockSignUpWebservice,
                                                      delegate: mockSignUpDelegate)
        sut.signUpPresenter = mockSignUpPresenter
        sut.signUpButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(mockSignUpPresenter.proccessUserSignUpCalled)
    }
}
