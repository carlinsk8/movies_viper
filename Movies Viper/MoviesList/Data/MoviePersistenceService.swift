//
//  MoviePersistenceService.swift
//  Movies Viper
//
//  Created by Carlos on 24/04/25.
//

import Foundation
import CoreData

class MoviePersistenceService {
    static let shared = MoviePersistenceService()
    private let context = CoreDataManager.shared.context

    func saveMovies(_ movies: [Movie]) {
        // Eliminar existentes
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CDMovie.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
        } catch {
            print("❌ Error deleting old data: \(error.localizedDescription)")
        }

        // Insertar nuevas
        for movie in movies {
            let cdMovie = CDMovie(context: context)
            cdMovie.id = Int64(movie.id)
            cdMovie.title = movie.title
            cdMovie.overview = movie.overview
            cdMovie.posterPath = movie.posterPath
            cdMovie.voteAverage = movie.voteAverage
            cdMovie.releaseDate = movie.releaseDate
        }

        CoreDataManager.shared.saveContext()
    }

    func fetchCachedMovies() -> [Movie] {
        let request: NSFetchRequest<CDMovie> = CDMovie.fetchRequest()
        do {
            let cdMovies = try context.fetch(request)
            return cdMovies.map {
                Movie(
                    id: Int($0.id),
                    title: $0.title ?? "",
                    overview: $0.overview ?? "",
                    posterPath: $0.posterPath,
                    voteAverage: $0.voteAverage,
                    releaseDate: $0.releaseDate ?? ""
                )
            }
        } catch {
            print("❌ Failed to fetch cached movies: \(error.localizedDescription)")
            return []
        }
    }
}
