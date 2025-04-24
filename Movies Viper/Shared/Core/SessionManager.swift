//
//  SessionManager.swift
//  Movies Viper
//
//  Created by Carlos on 24/04/25.
//

import Foundation

enum SessionManager {
    static var isLoggedIn: Bool {
        get { UserDefaults.standard.bool(forKey: "isLoggedIn") }
        set { UserDefaults.standard.set(newValue, forKey: "isLoggedIn") }
    }

    static func logout() {
        isLoggedIn = false
    }
}
