//
//  FirebaseAuthService.swift
//  SwiftUI-MVVM-Login
//
//  Created by Yusuke Miyata on 2021/12/05.
//

import Combine
import FirebaseAuth

protocol IFirebaseAuthService: AnyObject {
    func addStateDidChangeListener(completion: @escaping (Bool) -> Void)
    func removeStateDidChangeListener()
    func signIn(email: String?, password: String?, completion: @escaping (Error?) -> Void)
    func signUp(email: String?, password: String?, completion: @escaping (Error?) -> Void)
    func signOut()
}

final class FirebaseAuthService: IFirebaseAuthService {
    public static let shared = FirebaseAuthService()

    private var handler: AuthStateDidChangeListenerHandle?

    private init() {}

    deinit {
        removeStateDidChangeListener()
    }

    func addStateDidChangeListener(completion: @escaping (Bool) -> Void) {
        handler = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let _ = user {
                completion(true)
            } else {
                completion(false)
            }
        }
    }

    func removeStateDidChangeListener() {
        if let handler = handler {
            Auth.auth().removeStateDidChangeListener(handler)
        }
    }

    func signUp(email: String?, password: String?, completion: @escaping (Error?) -> Void) {
        guard let email = email, let password = password else {
            completion(nil)
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            completion(error)
        }
    }

    func signIn(email: String?, password: String?, completion: @escaping (Error?) -> Void) {
        guard let email = email, let password = password else {
            completion(nil)
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            completion(error)
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
        }
        catch(let error) {
            debugPrint(error.localizedDescription)
        }
    }
}


