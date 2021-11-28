
//  LoginViewTests.swift
//  SwiftUI-MVVM-LoginUITests
//
//  Created by Yusuke Miyata on 2021/11/28.
//

import XCTest
import SwiftUI_MVVM_Login
@testable import SwiftUI_MVVM_Login

class LoginViewTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCanLoginButtonTap() throws {
        let app = XCUIApplication()
        app.launch()

        let loginButton = app.buttons["loginButton"]
        XCTAssertEqual(false, loginButton.isEnabled)

        let emailTextField = app.textFields["loginEmailTextField"]
        let passwordSecureField = app.secureTextFields["loginPasswordSecureField"]

        emailTextField.tap()
        emailTextField.typeText("test")

        passwordSecureField.tap()
        passwordSecureField.typeText("111")

        XCTAssertEqual(true, loginButton.isEnabled)
    }
}
