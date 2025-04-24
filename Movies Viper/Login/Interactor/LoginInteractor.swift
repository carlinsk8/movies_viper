//
//  LoginInteractor.swift
//  Movies Viper
//
//  Created by Carlos on 23/04/25.
//

class LoginInteractor: LoginInteractorProtocol {
    weak var output: LoginInteractorOutputProtocol?

    func validateUser(username: String, password: String) {
        if username == "Admin" && password == "Password*123" {
            output?.loginSucceeded()
        } else {
            output?.loginFailed(error: "Invalid credentials")
        }
    }
}
