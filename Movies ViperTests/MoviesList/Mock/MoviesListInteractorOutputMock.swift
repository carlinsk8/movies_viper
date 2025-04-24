//
//  MoviesListInteractorOutputMock.swift
//  Movies Viper
//
//  Created by Carlos on 24/04/25.
//

@testable import Movies_Viper

class MoviesListInteractorOutputMock: MoviesListInteractorOutputProtocol {
    var didLoadFromCache = false
    var didShowError = false
    var fetchedMovies: [Movie] = []
    var errorMessage: String?

    var didFetchMovies = false

    func moviesFetched(_ movies: [Movie]) {
        didFetchMovies = true
        fetchedMovies = movies
    }

    func moviesFetchFailed(_ error: String) {
        didShowError = true
        errorMessage = error
    }
}
