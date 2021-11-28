//
//  LoginCredentials.swift
//  SwiftUI-MVVM-Login
//
//  Created by Yusuke Miyata on 2021/11/28.
//

import Foundation

enum LoginValidateError: Error {
    case emailEmpty
    case passwordEmpty

    var localizedDescription: String {
        switch self {
            case .emailEmpty: return "emailEmpty"
            case .passwordEmpty: return "passwordEmpty"
        }
    }
}

protocol ILoginValidator {
    func validate(email: String, password: String) -> String
}

final class LoginValidator: ILoginValidator {
    func validate(email: String, password: String) -> String {
        if email.isEmpty {
            return LoginValidateError.emailEmpty.localizedDescription
        }

        if password.isEmpty {
            return LoginValidateError.passwordEmpty.localizedDescription
        }

        return ""
    }
}
