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
        let router = MoviesListRouter()

        // Inyectar dependencias requeridas
        let apiService = MoviesAPIService() // Tu implementación real del API service
        let persistenceService = MoviePersistenceService.shared // o una instancia si no es singleton
        let reachability: ReachabilityChecking = ReachabilityService.shared
        let interactor = MoviesListInteractor(apiService: apiService, persistenceService: persistenceService, reachability: reachability)

        // Enlazar componentes
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter

        return view
    }
}

