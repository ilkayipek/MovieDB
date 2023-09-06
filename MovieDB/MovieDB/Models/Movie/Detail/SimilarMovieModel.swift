//
//  SimilarMovieModel.swift
//  MovieDB
//
//  Created by MacBook on 29.08.2023.
//

import Foundation

// MARK: - SimilarMovieModel
struct SimilarMovieModel: Decodable, DetailMovieCollectionModelProtocol {
    var collectionTitle: String?
    let page: Int?
    let results: [MovieResult]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
