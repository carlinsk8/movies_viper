//
//  Movie.swift
//  Movies Viper
//
//  Created by Carlos on 24/04/25.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let voteAverage: Double
    let releaseDate: String

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
}

struct MoviesResponse: Decodable {
    let results: [Movie]
    let page: Int
}
