//
//  ContentView.swift
//  SwiftUI-MVVM-Login
//
//  Created by Yusuke Miyata on 2021/11/28.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel: ContentViewModel

    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        if viewModel.isLogin {
            Button(action: { viewModel.didTapLogoutButton.send() }) {
                Text("Logout")
            }
        } else {
            LoginView(viewModel: LoginViewModel(
                loginValidator: LoginValidator(),
                firebaseAuthService: FirebaseAuthService.shared
            ))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel(firebaseAuthService: FirebaseAuthService.shared))
    }
}
