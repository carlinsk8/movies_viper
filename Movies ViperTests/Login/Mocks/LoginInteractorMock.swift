//
//  LoginInteractorMock.swift
//  Movies Viper
//
//  Created by Carlos on 24/04/25.
//

@testable import Movies_Viper

class LoginInteractorMock: LoginInteractorProtocol {
    weak var output: LoginInteractorOutputProtocol?

    var didValidateUser = false
    var lastUsername: String?
    var lastPassword: String?

    func validateUser(username: String, password: String) {
        didValidateUser = true
        lastUsername = username
        lastPassword = password

        if username.trimmingCharacters(in: .whitespaces) == "Admin" &&
           password.trimmingCharacters(in: .whitespaces) == "Password*123" {
            output?.loginSucceeded()
        } else {
            output?.loginFailed(error: "Invalid credentials")
        }
    }
}
