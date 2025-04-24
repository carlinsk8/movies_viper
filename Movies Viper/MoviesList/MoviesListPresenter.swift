//
//  MoviesListPresenter.swift
//  Movies Viper
//
//  Created by Carlos on 23/04/25.
//

import UIKit

class MoviesListPresenter: MoviesListPresenterProtocol, MoviesListInteractorOutputProtocol {
    func didSelectMovie(_ movie: Movie) {
        if let viewController = view as? UIViewController {
            router?.navigateToMovieDetail(from: viewController, movie: movie)
        }
    }
    
    weak var view: MoviesListViewProtocol?
    var interactor: MoviesListInteractorProtocol?
    var router: MoviesListRouterProtocol?
    private var movies: [Movie] = []
    private var currentPage = 1
    private var isLoadingMore = false

    func viewDidLoad() {
        interactor?.fetchUpcomingMovies(page: currentPage)
    }

    func loadMoreMovies() {
        guard !isLoadingMore else { return }
        isLoadingMore = true
        currentPage += 1
        interactor?.fetchUpcomingMovies(page: currentPage)
    }

    func moviesFetched(_ newMovies: [Movie]) {
        isLoadingMore = false
        movies.append(contentsOf: newMovies)
        view?.showMovies(movies)
    }

    func moviesFetchFailed(_ error: String) {
        isLoadingMore = false
        DispatchQueue.main.async {
            self.view?.showError(error)
        }
    }
}

    
