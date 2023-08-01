//
//  PopularMovieModel.swift
//  MovieDB
//
//  Created by MacBook on 1.08.2023.
//

// MARK: - Populer Movies Model
struct PopularMoviesModel: Decodable, MovieModelProtocol {
    var collectionTitle: String?
    let page: Int?
    let results: [MovieResult]?
    let statusCode: Int?
    let statusMessage: String?
    let success: Bool?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case page, results, success
    }
}
