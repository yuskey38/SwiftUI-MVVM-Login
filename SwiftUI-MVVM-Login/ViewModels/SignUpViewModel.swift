//
//  SignUpViewModel.swift
//  SwiftUI-MVVM-Login
//
//  Created by Yusuke Miyata on 2021/12/04.
//

import Foundation
import FirebaseAuth
import Combine

final class SignUpViewModel: ObservableObject {
    // binding: ViewModelでもViewでも値を変えられるもの
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isShowError: (isShow: Bool, message: String) = (false, "")

    // Input: Viewで発生するイベントをViewModelで検知するためのもの
    let didTapSignUpButton = PassthroughSubject<Void, Never>()

    // output: ViewModelでなにかしらの処理をした結果をViewに通知するためのもの
    @Published private(set) var isSignUpEnabled: Bool = false
    @Published private(set) var invalidMessage: String = ""

    // cancellable
    private var cancellables = Set<AnyCancellable>()

    init(loginValidator: LoginValidator) {
        let isSignUpEnabled = $invalidMessage.dropFirst().map { $0.isEmpty }
        let invalidMessage = Publishers.CombineLatest($email, $password)
            .dropFirst()
            .map { loginValidator.validate(email: $0, password: $1) }

        let signUp = didTapSignUpButton
            .sink(receiveValue: { [weak self] in
                guard let email = self?.email, let password = self?.password else { return }
                Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
                    guard let strongSelf = self else { return }
                    if let error = error {
                        strongSelf.isShowError = (true, error.localizedDescription)
                    }
                }
            })


        cancellables.formUnion([
            isSignUpEnabled.assign(to: \.isSignUpEnabled, on: self),
            invalidMessage.assign(to: \.invalidMessage, on: self),
            signUp
        ])
    }
}
