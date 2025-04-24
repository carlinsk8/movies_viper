//
//  MoviesAPIServiceMock.swift
//  Movies Viper
//
//  Created by Carlos on 24/04/25.
//

@testable import Movies_Viper
import Foundation

class MoviesAPIServiceMock: MoviesAPIServiceProtocol {
    var shouldSimulateNetworkError = false
    var mockedMovies: [Movie] = []

    func fetchUpcomingMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        if shouldSimulateNetworkError {
            completion(.failure(NSError(domain: "", code: -1009, userInfo: nil))) // Simula sin conexión
        } else {
            completion(.success(mockedMovies)) // Simula respuesta exitosa
        }
    }
}
