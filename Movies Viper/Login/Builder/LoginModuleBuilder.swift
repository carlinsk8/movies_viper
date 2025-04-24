//
//  LoginModuleBuilder.swift
//  Movies Viper
//
//  Created by Carlos on 23/04/25.
//

import UIKit

class LoginModuleBuilder {
    static func build() -> UIViewController {
        let view = LoginViewController()
        let presenter = LoginPresenter()
        let interactor = LoginInteractor()
        let router = LoginRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router

        interactor.output = presenter
        router.viewController = view

        return view
    }
}
