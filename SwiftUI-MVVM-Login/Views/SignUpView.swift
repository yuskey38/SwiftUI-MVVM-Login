//
//  SignUpView.swift
//  SwiftUI-MVVM-Login
//
//  Created by Yusuke Miyata on 2021/12/04.
//

import SwiftUI

import SwiftUI

struct SignUpView: View {
    @ObservedObject private var viewModel: SignUpViewModel

    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            invalidMessage
            emailTextField
            passwordSecureField
            loginButton
        }
        .alert(viewModel.isShowError.message,
               isPresented: $viewModel.isShowError.isShow,
               actions: {
            Button("OK", role: .none, action: {
                viewModel.isShowError = (false, "")
            })
        })

    }

    var emailTextField: some View {
        TextField("Eメール", text: $viewModel.email)
            .textFieldStyle(.roundedBorder)
            .autocapitalization(.none)
            .padding()
            .accessibility(identifier: "signUpEmailTextField")
    }

    var passwordSecureField: some View {
        SecureField("パスワード", text: $viewModel.password)
            .textFieldStyle(.roundedBorder)
            .autocapitalization(.none)
            .padding()
            .accessibility(identifier: "signUpPasswordSecureField")
    }

    var loginButton: some View {
        Button(action: { viewModel.didTapSignUpButton.send() }) {
            Text("新規登録")
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color(.orange))
                .cornerRadius(24)
                .padding()
                .disabled(!viewModel.isSignUpEnabled)
                .opacity(viewModel.isSignUpEnabled ? 1: 0.5)
                .accessibility(identifier: "signUpButton")
        }
    }

    var invalidMessage: some View {
        Text(viewModel.invalidMessage)
            .foregroundColor(.red)
            .accessibility(identifier: "signUpInvalidMessage")
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: SignUpViewModel(loginValidator: LoginValidator()))
    }
}
