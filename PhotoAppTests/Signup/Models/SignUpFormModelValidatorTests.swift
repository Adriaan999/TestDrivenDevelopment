//
//  SignUpFormModelValidatorTests.swift
//  PhotoAppTests
//
//  Created by Adriaan van Schalkwyk on 2021/03/24.
//

import XCTest
@testable import PhotoApp

class SignUpFormModelValidatorTests: XCTestCase {
    
    var sut: SignUpFormModelValidator!
    
    override func setUpWithError() throws {
        sut = SignUpFormModelValidator()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testSignUpFormModelValidator_WhenValidFirstNameProvided_ShouldReturnTrue() {
        let isFirstNameValid = sut.isFirstNameValid(firstName: "Adriaan")
        XCTAssert(isFirstNameValid, "The isFirstNameValide() should have returned TRUE for a valid first name but returned FALSE")
    }
    
    func testSignUpFormModelValidator_WhenToShortFirstNameProvided_ShouldReturnFalse() {
        let isFirstNameValide = sut.isFirstNameValid(firstName: "A")
        XCTAssertFalse(isFirstNameValide, "The isFirstNameValide() should have returned FALSE for a first name that is shorter than \(SignUpConstants.firstNameMinLength) characters but it has returned TRUE")
    }
    
    func testSignUpFormModelValidator_WhenToLongFirstNameProvided_ShouldReturnFalse() {
        let isFirstNameValide = sut.isFirstNameValid(firstName: "AdriaanAdriaan")
        XCTAssertFalse(isFirstNameValide, "The isFirstNameValide() should have returned FALSE for a first name that is longer than \(SignUpConstants.firstNameMaxLength) characters but it has returned TRUE")
    }
    
    func testSignUpFormModelValidator_WhenValidLastNameProvided_ShouldReturnTrue() {
        let isLastNameValid = sut.isLastNameValid(lastName: "van Schalkwyk")
        XCTAssert(isLastNameValid, "The isLastNameValid() should have returned TRUE for a valid last name but returned FALSE")
    }
    
    func testSignUpFormModelValidator_WhenToShortLastNameProvided_ShouldReturnFalse() {
        let isLastNameValid = sut.isLastNameValid(lastName: "v")
        XCTAssertFalse(isLastNameValid, "The isLastNameValid() should have returned FALSE for a last name that is shorter than \(SignUpConstants.lastNameMinLength) characters but it has returned TRUE")
    }
    
    func testSignUpFormModelValidator_WhenToLongLastNameProvided_ShouldReturnFalse() {
        let isLastNameValid = sut.isLastNameValid(lastName: "van Schalkwykvan Schalkwyk")
        XCTAssertFalse(isLastNameValid, "The isLastNameValid() should have returned FALSE for a last name that is shorter than \(SignUpConstants.lastNameMaxLength) characters but it has returned TRUE")
    }
    
    func testSignUpFormModelValidator_WhenValidEmailProvided_ShouldReturnTrue() {
        let isEmailValide = sut.isEmailValid(email: "adriaan9@hotmail.co.za")
        XCTAssert(isEmailValide, "The isEmailValid() should have returned TRUE for a valid email but returned FALSE")
    }
    
    func testSignUpFormModelValidator_WhenInvalidEmailProvided_ShouldReturnFalse() {
        let isEmailValide = sut.isEmailValid(email: "adriaan9hotmail.co.za")
        XCTAssertFalse(isEmailValide, "The isEmailValid() should have returned FALSE for a invalid email but returned TRUE")
    }
    
    
    func testSignupFormModelValidator_WhenValidPasswordProvided_ShouldReturnTrue() {
        let isPasswordValid = sut.isPasswordValid(password: "12345678")
        XCTAssertTrue(isPasswordValid, "The isPasswordValid() should have returned TRUE for a valid password  but it has returned FALSE")
    }
    
    func testSignupFormModelValidator_WhenTooShortPasswordProvided_ShouldReturnFalse() {
        let isPasswordValid = sut.isPasswordValid(password: "12")
        XCTAssertFalse(isPasswordValid, "The isPasswordValid() should have returned FALSE for a password that is shorter than \(SignUpConstants.passwordMinLength) but it has returned TRUE")
    }
    
    func testSignupFormModelValidator_WhenTooLongPasswordProvided_ShouldReturnFalse() {
        let isPasswordValid = sut.isPasswordValid(password: "12345678901234567")
        XCTAssertFalse(isPasswordValid, "The isPasswordValid() should have returned FALSE for a password that is longer than \(SignUpConstants.passwordMaxLength) but it has returned TRUE")
    }
    
    func testSignupFormModelValidator_WhenPasswordsMatch_ShouldReturnTrue() {
        let passwordsMatch = sut.passwordsMatch(password: "123456", repeatPassword: "123456")
        XCTAssertTrue(passwordsMatch, "The passwordsMatch() should have returned TRUE for matching passwords but it has returned FALSE")
    }
    
    func testSignupFormModelValidator_WhenPasswordsMatch_ShouldReturnFalse() {
        let passwordsMatch = sut.passwordsMatch(password: "123456", repeatPassword: "1234567")
        XCTAssertFalse(passwordsMatch, "The passwordsMatch() should have returned FALSE for passwords that do not match but it has returned TRUE")
    }
}
