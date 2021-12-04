//
//  LoginViewModel.swift
//  SwiftUI-MVVM-Login
//
//  Created by Yusuke Miyata on 2021/11/28.
//

import Foundation
import Combine

final class LoginViewModel: ObservableObject {
    // binding: ViewModelでもViewでも値を変えられるもの
    @Published var email: String = ""
    @Published var password: String = ""

    @Published var isLoginCompleted: Bool = false

    // Input: Viewで発生するイベントをViewModelで検知するためのもの
    let didTapLoginButton = PassthroughSubject<Void, Never>()

    // output: ViewModelでなにかしらの処理をした結果をViewに通知するためのもの
    @Published private(set) var isLoginEnabled: Bool = false
    @Published private(set) var invalidMessage: String = ""

    // cancellable
    private var cancellables = Set<AnyCancellable>()

    init(loginValidator: LoginValidator) {
        let isLoginEnabled = $invalidMessage.dropFirst().map { $0.isEmpty }
        let invalidMessage = Publishers.CombineLatest($email, $password)
            .dropFirst()
            .map { loginValidator.validate(email: $0, password: $1) }


        let isLoginCompleted = didTapLoginButton
            .flatMap {
                
                Just(true)
            }

        cancellables.formUnion([
            isLoginEnabled.assign(to: \.isLoginEnabled, on: self),
            invalidMessage.assign(to: \.invalidMessage, on: self),
            isLoginCompleted.assign(to: \.isLoginCompleted, on: self)
        ])
    }
}
