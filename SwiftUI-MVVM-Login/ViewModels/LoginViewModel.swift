//
//  LoginViewModel.swift
//  SwiftUI-MVVM-Login
//
//  Created by Yusuke Miyata on 2021/11/28.
//

import Combine

final class LoginViewModel: ObservableObject {
    // binding: ViewModelでもViewでも値を変えられるもの
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isShowError: (isShow: Bool, message: String) = (false, "")
    
    // Input: Viewで発生するイベントをViewModelで検知するためのもの
    let didTapLoginButton = PassthroughSubject<Void, Never>()
    
    // output: ViewModelでなにかしらの処理をした結果をViewに通知するためのもの
    @Published private(set) var invalidMessage: String = ""
    @Published private(set) var isLoginEnabled: Bool = false
    
    // cancellable
    private var cancellables = Set<AnyCancellable>()
    
    init(loginValidator: LoginValidator,
         firebaseAuthService: IFirebaseAuthService) {
        Publishers.CombineLatest($email, $password)
            .dropFirst()
            .map { loginValidator.validate(email: $0, password: $1) }
            .assign(to: &$invalidMessage)

        $invalidMessage.dropFirst().map { $0.isEmpty }.assign(to: &$isLoginEnabled)
        
        didTapLoginButton
            .sink(receiveValue: { [weak self] in
                firebaseAuthService.signIn(email: self?.email, password: self?.password, completion: {
                    if let error = $0 {
                        self?.isShowError = (true, error.localizedDescription)
                    }
                })
            })
            .store(in: &cancellables)
    }
}
