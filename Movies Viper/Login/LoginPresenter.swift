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
        interactor?.validateUser(username: username, password: password)
    }

    func loginSucceeded() {
        SessionManager.isLoggedIn = true
        router?.navigateToMovieList()
    }

    func loginFailed(error: String) {
        view?.showError(error)
    }
}
