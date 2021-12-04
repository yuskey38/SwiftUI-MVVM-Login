//
//  ContentViewModel.swift
//  SwiftUI-MVVM-Login
//
//  Created by Yusuke Miyata on 2021/12/03.
//

import FirebaseAuth
import Combine

final class ContentViewModel: ObservableObject {
    @Published var isLogin: Bool = false

    private let firebaseAuthService: IFirebaseAuthService

    // Input: Viewで発生するイベントをViewModelで検知するためのもの
    let didTapLogoutButton = PassthroughSubject<Void, Never>()

    // cancellable
    private var cancellables = Set<AnyCancellable>()

    init(firebaseAuthService: IFirebaseAuthService) {
        self.firebaseAuthService = firebaseAuthService
        firebaseAuthService.addStateDidChangeListener(completion: { [weak self] in
            self?.isLogin = $0
        })

        didTapLogoutButton
            .sink(receiveValue: {
                firebaseAuthService.signOut()
            })
            .store(in: &cancellables)
    }
}
