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
            Text(viewModel.invalidMessage)
                .foregroundColor(.red)
                .accessibility(identifier: "loginInvalidMessage")
            TextField("Eメール", text: $viewModel.email)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
                .padding()
                .accessibility(identifier: "loginEmailTextField")
            SecureField("パスワード", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
                .padding()
                .accessibility(identifier: "loginPasswordSecureField")

            HStack {
                Button(action: { viewModel.didTapLoginButton.send() }) {
                    Image(systemName: "hand.thumbsup.fill")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(.orange))
                        .cornerRadius(24)
                        .padding()
                        .opacity(viewModel.isLoginEnabled ? 1 : 0.5)
                        .accessibility(identifier: "loginButton")
                }.disabled(!viewModel.isLoginEnabled)


                NavigationLink(destination: signUpView) {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(.orange))
                        .cornerRadius(24)
                        .padding()
                        .accessibility(identifier: "toSignUpButton")
                }
            }
        }.alert(viewModel.isShowError.message,
                isPresented: $viewModel.isShowError.isShow,
                actions: { [weak viewModel] in
            Button("OK", role: .none, action: {
                viewModel?.isShowError = (false, "")
            })
        })
    }
}

    var signUpView: some View {
        SignUpView(viewModel: SignUpViewModel(
            loginValidator: LoginValidator(),
            firebaseAuthService: FirebaseAuthService.shared
        ))
    }

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(
            viewModel: LoginViewModel(
                loginValidator: LoginValidator(),
                firebaseAuthService: FirebaseAuthService.shared
            )
        )
    }
}
