//
//  MovieTrailerModel.swift
//  MovieDB
//
//  Created by MacBook on 20.08.2023.
//

// MARK: - MovieTrailerModel
struct MovieTrailerModel: Decodable, DetailMovieCollectionModelProtocol{
    let id: Int?
    var collectionTitle: String?
    let results: [MovieTrailerResultModel]?
}
