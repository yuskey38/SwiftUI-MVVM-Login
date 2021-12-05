//
//  SwiftUI_MVVM_LoginApp.swift
//  SwiftUI-MVVM-Login
//
//  Created by Yusuke Miyata on 2021/11/28.
//

import SwiftUI
import Firebase

@main
struct SwiftUI_MVVM_LoginApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(viewModel: ContentViewModel(firebaseAuthService: FirebaseAuthService.shared))
            }
        }
    }
}
