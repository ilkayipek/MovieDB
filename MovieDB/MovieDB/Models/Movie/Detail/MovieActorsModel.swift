//
//  MovieActorsModel.swift
//  MovieDB
//
//  Created by MacBook on 20.08.2023.
//

// MARK: - MovieActorsModel
struct MovieActorsModel: Decodable, DetailMovieCollectionModelProtocol {
    let id: Int?
    let cast, crew: [Cast]?
    var collectionTitle: String?
    let statusCode: Int?
    let statusMessage: String?
    let success: Bool?
    let errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case errorMessage = "error_message"
        case success, id , crew, cast
    }
}
