//
//  ContentViewModel.swift
//  SwiftUI-MVVM-Login
//
//  Created by Yusuke Miyata on 2021/12/03.
//

import Foundation
import Firebase
import Combine

final class ContentViewModel: ObservableObject {
    @Published var isLogin: Bool = false

    // Input: Viewで発生するイベントをViewModelで検知するためのもの
    let didTapLogoutButton = PassthroughSubject<Void, Never>()

    // cancellable
    private var cancellables = Set<AnyCancellable>()

    private var handler: AuthStateDidChangeListenerHandle?

    init() {
        handler = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let _ = user {
                print("sign-in")
                self.isLogin = true
            } else {
                print("sign-out")
                self.isLogin = false
            }
        }

        didTapLogoutButton
            .sink(receiveValue: {
                do { try Auth.auth().signOut() }
                catch { }
            })
            .store(in: &cancellables)
    }

    deinit {
        if let handler = handler {
            Auth.auth().removeStateDidChangeListener(handler)
        }
    }
}