//
//  LoginCredentials.swift
//  SwiftUI-MVVM-Login
//
//  Created by Yusuke Miyata on 2021/11/28.
//

import Foundation

enum LoginValidateError: Error {
    case isEmailEmpty
    case isPasswordEmpty

    var localizedDescription: String {
        switch self {
            case .isEmailEmpty: return "isEmailEmpty"
            case .isPasswordEmpty: return "isPasswordEmpty"
        }
    }
}

protocol ILoginValidator {
    func validate(email: String, password: String) -> String
}

final class LoginValidator {
    func validate(email: String, password: String) -> String {
        if email.isEmpty {
            return LoginValidateError.isEmailEmpty.localizedDescription
        }

        if password.isEmpty {
            return LoginValidateError.isPasswordEmpty.localizedDescription
        }

        return ""
    }
}
