//
//  TrendMovieModel.swift
//  MovieDB
//
//  Created by MacBook on 1.08.2023.
//

// MARK: - TrendMoviesModel
struct TrendMoviesModel: Decodable, MovieModelProtocol, FetchResultStatusProtocol {
    var collectionTitle: String?
    let page: Int?
    let results: [MovieResult]?
    let totalPages, totalResults: Int?
    var statusCode: Int?
    var statusMessage: String?
    var success: Bool?

    enum CodingKeys: String, CodingKey {
        case page, results, success
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}
