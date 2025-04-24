//
//  LoginViewMock.swift
//  Movies Viper
//
//  Created by Carlos on 24/04/25.
//

@testable import Movies_Viper
import UIKit

class LoginViewMock: LoginViewProtocol {
    var didShowError = false
    var errorMessage: String?

    func showError(_ message: String) {
        didShowError = true
        errorMessage = message
    }
}

class LoginRouterMock: LoginRouterProtocol {
    var didNavigateToMovieList = false

    func navigateToMovieList() {
        didNavigateToMovieList = true
    }
}

