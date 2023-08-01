//
//  MovieResult.swift
//  MovieDB
//
//  Created by MacBook on 1.08.2023.
//

import Foundation

struct MovieResult: Decodable {
    let adult, video: Bool?
    let genreIDS: [Int]?
    let originalTitle, overview, posterPath, originalLanguage, releaseDate, backdropPath, title, firstAirDate, name, originalName: String?
    let voteAverage, popularity: Double?
    let voteCount, id: Int?
    let originCountry: [String]?

    enum CodingKeys: String, CodingKey {
        case adult, id, overview, popularity, name, title, video
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
  
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
        case originalName = "original_name"
    }
}
