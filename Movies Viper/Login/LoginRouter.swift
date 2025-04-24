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
        viewController?.navigationController?.pushViewController(movieListVC, animated: true)
    }
}
