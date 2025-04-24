//
//  MoviePersistenceServiceMock.swift
//  Movies Viper
//
//  Created by Carlos on 24/04/25.
//

@testable import Movies_Viper

class MoviePersistenceServiceMock: MoviePersistenceServiceProtocol {
    var cachedMovies: [Movie] = []
    var didFetch = false
    var didSave = false

    func fetchCachedMovies() -> [Movie] {
        didFetch = true
        return cachedMovies
    }

    func saveMovies(_ movies: [Movie]) {
        didSave = true
        cachedMovies = movies
    }
}

