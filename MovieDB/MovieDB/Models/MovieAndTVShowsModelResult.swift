//
//  MovieAndTVShowsModelResult.swift
//  MovieDB
//
//  Created by MacBook on 19.10.2023.
//

// MARK: - MovieAndTVShowsModelResult
struct MovieAndTVShowsModelResult: Decodable, FetchResultStatusProtocol {
    let adult: Bool?
    let backdropPath: String?
    let id: Int?
    let title: String?
    let originalLanguage: String?
    let originalTitle, overview, posterPath: String?
    let mediaType: MediaType?
    let genreids: [Int]?
    let popularity: Double?
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let name, originalName, firstAirDate: String?
    let originCountry: [String]?
    var statusCode: Int?
    var statusMessage: String?
    var success: Bool?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreids = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case name
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success
    }
}

