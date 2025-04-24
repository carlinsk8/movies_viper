//
//  MoviesListRouter.swift
//  Movies Viper
//
//  Created by Carlos on 23/04/25.
//

import UIKit

class MoviesListRouter: MoviesListRouterProtocol {
    func navigateToMovieDetail(from view: UIViewController, movie: Movie) {
        // Este será reemplazado por MovieDetailModuleBuilder.build(movie: movie)
        let detailVC = UIViewController()
        detailVC.title = movie.title
        detailVC.view.backgroundColor = .white
        view.navigationController?.pushViewController(detailVC, animated: true)
    }
}
