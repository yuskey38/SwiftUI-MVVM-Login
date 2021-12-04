//
//  AppDelegate.swift
//  SwiftUI-MVVM-Login
//
//  Created by Yusuke Miyata on 2021/12/03.
//

import Foundation
import Firebase

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()

        return true
    }
}
