//
//  MoviesListBuilder.swift
//  Movies Viper
//
//  Created by Carlos on 24/04/25.
//

import UIKit

class MoviesListBuilder {
    static func build() -> UIViewController {
        let view = MoviesListViewController()
        let presenter = MoviesListPresenter()
        let interactor = MoviesListInteractor()
        let router = MoviesListRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter

        return view
    }
}
