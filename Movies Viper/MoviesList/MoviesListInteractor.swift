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
        guard !isFetching else { return }
        isFetching = true

        let urlString = "\(Environment.baseURL)/movie/upcoming?api_key=\(Environment.apiKey)&language=es-PE&page=\(page)"
        print("URL: \(urlString)")
        guard let url = URL(string: urlString) else {
            output?.moviesFetchFailed("URL inválida")
            isFetching = false
            return
        }

        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        config.timeoutIntervalForResource = 20
        let session = URLSession(configuration: config)

        session.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            defer { self.isFetching = false }

            if let error = error {
                self.output?.moviesFetchFailed(error.localizedDescription)
                return
            }

            guard let data = data else {
                self.output?.moviesFetchFailed("No hay datos")
                return
            }

            do {
                let response = try JSONDecoder().decode(MoviesResponse.self, from: data)
                self.output?.moviesFetched(response.results)
            } catch {
                self.output?.moviesFetchFailed("Error al parsear: \(error.localizedDescription)")
            }
        }.resume()
    }
}
