//
//  MoviesAPIService.swift
//  Movies Viper
//
//  Created by Carlos on 24/04/25.
//

import Foundation

class MoviesAPIService: MoviesAPIServiceProtocol {
    
    func fetchUpcomingMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let urlString = "\(Environment.baseURL)/movie/upcoming?api_key=\(Environment.apiKey)&language=es-PE&page=\(page)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "URL inválida"])))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No hay datos"])))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(decoded.results))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
