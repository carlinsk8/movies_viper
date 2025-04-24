//
//  MoviesListRouter.swift
//  Movies Viper
//
//  Created by Carlos on 23/04/25.
//

import UIKit

class MoviesListRouter: MoviesListRouterProtocol {
    func navigateToMovieDetail(from view: UIViewController, movie: Movie) {
        let detailVC = MovieDetailViewController(movie: movie)
        
        if let sheet = detailVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()] // Estilo como en la imagen
            sheet.prefersGrabberVisible = true
        }
        
        view.present(detailVC, animated: true)
    }

}
