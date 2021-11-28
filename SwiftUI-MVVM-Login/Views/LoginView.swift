//
//  LoginView.swift
//  SwiftUI-MVVM-Login
//
//  Created by Yusuke Miyata on 2021/11/28.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject private var viewModel: LoginViewModel

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            invalidMessage
            emailTextField
            passwordSecureField
            loginButton
        }
        .alert("ログイン成功", isPresented: $viewModel.isLoginCompleted, actions: {})
    }

    var emailTextField: some View {
        TextField("Eメール", text: $viewModel.email)
            .textFieldStyle(.roundedBorder)
            .autocapitalization(.none)
            .padding()
    }

    var passwordSecureField: some View {
        SecureField("パスワード", text: $viewModel.password)
            .textFieldStyle(.roundedBorder)
            .autocapitalization(.none)
            .padding()
    }

    var loginButton: some View {
        Button(action: { viewModel.didTapLoginButton.send() }) {
            Text("ログイン")
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color(.orange))
                .cornerRadius(24)
                .padding()
                .disabled(!viewModel.isLoginEnabled)
                .opacity(viewModel.isLoginEnabled ? 1: 0.5)
        }
    }

    var invalidMessage: some View {
        Text(viewModel.invalidMessage)
            .foregroundColor(.red)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(
            viewModel: LoginViewModel(
                loginValidator: LoginValidator()
            )
        )
    }
}