//
//  LoginValidatorTests.swift
//  SwiftUI-MVVM-LoginTests
//
//  Created by Yusuke Miyata on 2021/11/28.
//

import XCTest
@testable import SwiftUI_MVVM_Login

class LoginValidatorTests: XCTestCase {

    private let model = LoginValidator()

    func testValidateForNoError() throws {
        let email = "email"
        let password = "password"
        let expected = ""

        let actual = model.validate(email: email, password: password)

        XCTAssertEqual(expected, actual)
    }

    func testValidateForEmailEmpty() throws {
        let email = ""
        let password = ""
        let expected = LoginValidateError.emailEmpty.localizedDescription

        let actual = model.validate(email: email, password: password)

        XCTAssertEqual(expected, actual)
    }

    func testValidateForPasswordEmpty() throws {
        let email = "email"
        let password = ""
        let expected = LoginValidateError.passwordEmpty.localizedDescription

        let actual = model.validate(email: email, password: password)

        XCTAssertEqual(expected, actual)
    }

}
