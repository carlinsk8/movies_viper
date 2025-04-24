//
//  MoviesListInteractor.swift
//  Movies Viper
//
//  Created by Carlos on 23/04/25.
//

import Foundation

class MoviesListInteractor: MoviesListInteractorProtocol {
    weak var output: MoviesListInteractorOutputProtocol?
    private var isFetching = false

    func fetchUpcomingMovies(page: Int) {
        if ReachabilityService.isConnectedToNetwork() {
            //  Hay internet → consumir API
            print("Conectado a internet")
            let urlString = "\(Environment.baseURL)/movie/upcoming?api_key=\(Environment.apiKey)&language=es-PE&page=\(page)"
            guard let url = URL(string: urlString) else {
                output?.moviesFetchFailed("URL inválida")
                return
            }

            let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let self = self else { return }

                if let error = error {
                    DispatchQueue.main.async {
                        self.output?.moviesFetchFailed("Error de red: \(error.localizedDescription)")
                    }
                    return
                }

                guard let data = data else {
                    DispatchQueue.main.async {
                        self.output?.moviesFetchFailed("Sin datos desde servidor")
                    }
                    return
                }

                do {
                    let response = try JSONDecoder().decode(MoviesResponse.self, from: data)
                    MoviePersistenceService.shared.saveMovies(response.results) // Guardar local
                    DispatchQueue.main.async {
                        self.output?.moviesFetched(response.results)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.output?.moviesFetchFailed("Error parseando: \(error.localizedDescription)")
                    }
                }
            }
            task.resume()

        } else {
            //  Sin internet → usar local
            print("Sin conexión a internet")
            let cached = MoviePersistenceService.shared.fetchCachedMovies()
            if cached.isEmpty {
                output?.moviesFetchFailed("Sin conexión y sin datos guardados.")
            } else {
                output?.moviesFetched(cached)
            }
        }
    }

}
