//
//  LoginPresenter.swift
//  Movies Viper
//
//  Created by Carlos on 23/04/25.
//

class LoginPresenter: LoginPresenterProtocol, LoginInteractorOutputProtocol {
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorProtocol?
    var router: LoginRouterProtocol?

    func loginTapped(username: String, password: String) {
        let trimmedUsername = username.trimmingCharacters(in: .whitespaces)
        let trimmedPassword = password.trimmingCharacters(in: .whitespaces)

        if trimmedUsername.isEmpty || trimmedPassword.isEmpty {
            view?.showError("Please enter username and password")
        } else {
            interactor?.validateUser(username: trimmedUsername, password: trimmedPassword)
        }
    }



    func loginSucceeded() {
        SessionManager.isLoggedIn = true
        router?.navigateToMovieList()
    }

    func loginFailed(error: String) {
        view?.showError(error)
    }
}
