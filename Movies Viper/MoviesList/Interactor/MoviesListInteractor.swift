//
//  MoviesListInteractor.swift
//  Movies Viper
//
//  Created by Carlos on 23/04/25.
//

import Foundation

class MoviesListInteractor: MoviesListInteractorProtocol {
    weak var output: MoviesListInteractorOutputProtocol?
    private let apiService: MoviesAPIServiceProtocol
    private let persistenceService: MoviePersistenceServiceProtocol
    private var isFetching = false
    private let reachability: ReachabilityChecking
    
    init(apiService: MoviesAPIServiceProtocol,
    persistenceService: MoviePersistenceServiceProtocol,
         reachability: ReachabilityChecking) {
        self.apiService = apiService
        self.persistenceService = persistenceService
        self.reachability = reachability
    }

    func fetchUpcomingMovies(page: Int) {
        if reachability.isConnectedToNetwork() {
            print("Conectado a internet")
            apiService.fetchUpcomingMovies(page: page) { [weak self] result in
                guard let self = self else { return }

                DispatchQueue.main.async {
                    switch result {
                    case .success(let movies):
                        self.persistenceService.saveMovies(movies)
                        self.output?.moviesFetched(movies)

                    case .failure(let error):
                        self.output?.moviesFetchFailed("Error de red: \(error.localizedDescription)")
                    }
                }
            }
        } else {
            print("Sin conexión a internet")
            let cached = persistenceService.fetchCachedMovies()
            if cached.isEmpty {
                output?.moviesFetchFailed("Sin conexión y sin datos guardados.")
            } else {
                output?.moviesFetched(cached)
            }
        }
    }


}
