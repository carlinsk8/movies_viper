//
//  LoginProtocols.swift
//  Movies Viper
//
//  Created by Carlos on 23/04/25.
//

import UIKit

// View
protocol LoginViewProtocol: AnyObject {
    func showError(_ message: String)
}

// Presenter
protocol LoginPresenterProtocol: AnyObject {
    func loginTapped(username: String, password: String)
}

// Interactor
protocol LoginInteractorProtocol: AnyObject {
    func validateUser(username: String, password: String)
}

// Interactor -> Presenter
protocol LoginInteractorOutputProtocol: AnyObject {
    func loginSucceeded()
    func loginFailed(error: String)
}

// Router
protocol LoginRouterProtocol: AnyObject {
    func navigateToMovieList()
}
