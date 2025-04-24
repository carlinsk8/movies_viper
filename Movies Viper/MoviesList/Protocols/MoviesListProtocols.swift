//
//  MoviesListProtocols.swift
//  Movies Viper
//
//  Created by Carlos on 24/04/25.
//

import UIKit

protocol MoviesListViewProtocol: AnyObject {
    func showMovies(_ movies: [Movie])
    func showError(_ message: String)
}

protocol MoviesListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func loadMoreMovies()
    func didSelectMovie(_ movie: Movie)
}

protocol MoviesListInteractorProtocol: AnyObject {
    func fetchUpcomingMovies(page: Int)
}

protocol MoviesListInteractorOutputProtocol: AnyObject {
    func moviesFetched(_ movies: [Movie])
    func moviesFetchFailed(_ error: String)
}

protocol MoviesListRouterProtocol: AnyObject {
    func navigateToMovieDetail(from view: UIViewController, movie: Movie)
}
