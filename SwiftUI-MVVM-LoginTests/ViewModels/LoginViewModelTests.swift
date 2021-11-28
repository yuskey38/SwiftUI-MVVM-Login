//
//  LoginViewModelTests.swift
//  SwiftUI-MVVM-LoginTests
//
//  Created by Yusuke Miyata on 2021/11/28.
//

import XCTest
@testable import SwiftUI_MVVM_Login

class LoginViewModelTests: XCTestCase {

    private let viewModel = LoginViewModel(loginValidator: LoginValidator())

    func testNoInvalidMessage() throws {
        let expected = ""

        viewModel.email = "email"
        viewModel.password = "password"

        XCTAssertEqual(expected, viewModel.invalidMessage)
    }

    func testEmailInvalidMessage() throws {
        let expected = LoginValidateError.isEmailEmpty.localizedDescription

        viewModel.email = ""
        viewModel.password = "password"

        XCTAssertEqual(expected, viewModel.invalidMessage)
    }

    func testPasswordInvalidMessage() throws {
        let expected = LoginValidateError.isPasswordEmpty.localizedDescription

        viewModel.email = "email"
        viewModel.password = ""

        XCTAssertEqual(expected, viewModel.invalidMessage)
    }
}
