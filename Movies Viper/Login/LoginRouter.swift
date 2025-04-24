//
//  LoginRouter.swift
//  Movies Viper
//
//  Created by Carlos on 23/04/25.
//

import UIKit

class LoginRouter: LoginRouterProtocol {
    weak var viewController: UIViewController?

    func navigateToMovieList() {
        let movieListVC = MoviesListBuilder.build()
        let nav = UINavigationController(rootViewController: movieListVC)
        nav.modalPresentationStyle = .fullScreen
        viewController?.present(nav, animated: true, completion: nil)


    }
}
