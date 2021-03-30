//
//  SignupFlowUITests.swift
//  PhotoAppUITests
//
//  Created by Adriaan van Schalkwyk on 2021/03/30.
//

import XCTest
@testable import PhotoApp

class SignupFlowUITests: XCTestCase {
    
    var app: XCUIApplication!
    var firstName: XCUIElement!
    var lastName: XCUIElement!
    var email: XCUIElement!
    var password: XCUIElement!
    var repeatPassword: XCUIElement!
    var signupButton: XCUIElement!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        app = XCUIApplication()
        app.launch()
        
        firstName = app.textFields["firstNameTextField"]
        lastName = app.textFields["lastNameTextField"]
        email = app.textFields["emailTextField"]
        password = app.secureTextFields["passwordTextField"]
        repeatPassword = app.secureTextFields["repeatPasswordTextField"]
        signupButton = app.buttons["signupButton"]
        
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
        firstName = nil
        lastName = nil
        email = nil
        password = nil
        repeatPassword = nil
        signupButton = nil
        try super.tearDownWithError()
    }
    
    func testSignupViewController_WhenViewLoaded_RequiredUIElementsAreEnabled() throws {
        XCTAssertTrue(firstName.isEnabled)
        XCTAssertTrue(lastName.isEnabled)
        XCTAssertTrue(email.isEnabled)
        XCTAssertTrue(password.isEnabled)
        XCTAssertTrue(repeatPassword.isEnabled)
        XCTAssertTrue(signupButton.isEnabled)
    }
    
    func testSignUpViewController_WhenInvalidFormIsSubmitted_PresentsErrorAlertdialog() {
        firstName.tap()
        firstName.typeText("S")
        
        lastName.tap()
        lastName.typeText("K")
        
        email.tap()
        email.typeText("@")
        
        password.tap()
        password.typeText("123456")
        
        repeatPassword.tap()
        repeatPassword.typeText("123")
        
        signupButton.tap()
        
        XCTAssertTrue(app.alerts["errorAlertDialog"].waitForExistence(timeout: 1))
    }
    
    func testSignUpViewController_WhenValidFormIsSubmitted_PresentsSuccessAlertdialog() {
        firstName.tap()
        firstName.typeText("Sergey")
        
        lastName.tap()
        lastName.typeText("Kargoplov")
        
        email.tap()
        email.typeText("test@test.com")
        
        password.tap()
        password.typeText("12345678")
        
        repeatPassword.tap()
        repeatPassword.typeText("12345678")
        
        signupButton.tap()
        
        XCTAssertTrue(app.alerts["successAlertDialog"].waitForExistence(timeout: 3))
    }
}
