//
//  LoginViewModelTests.swift
//  SwiftUI-MVVM-LoginTests
//
//  Created by Yusuke Miyata on 2021/11/28.
//

import XCTest
@testable import SwiftUI_MVVM_Login

class LoginViewModelTests: XCTestCase {

    private let viewModel = LoginViewModel(loginValidator: LoginValidator(), firebaseAuthService: FirebaseAuthService.shared)

    func testNoInvalidMessage() throws {
        let expected = ""

        viewModel.email = "email"
        viewModel.password = "password"

        XCTAssertEqual(expected, viewModel.invalidMessage)
    }

    func testEmailInvalidMessage() throws {
        let expected = LoginValidateError.emailEmpty.localizedDescription

        viewModel.email = ""
        viewModel.password = "password"

        XCTAssertEqual(expected, viewModel.invalidMessage)
    }

    func testPasswordInvalidMessage() throws {
        let expected = LoginValidateError.passwordEmpty.localizedDescription

        viewModel.email = "email"
        viewModel.password = ""

        XCTAssertEqual(expected, viewModel.invalidMessage)
    }
}
