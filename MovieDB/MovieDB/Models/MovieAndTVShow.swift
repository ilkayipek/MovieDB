//
//  MovieAndTVShow.swift
//  MovieDB
//
//  Created by MacBook on 18.10.2023.
//

import Foundation

// MARK: - MovieAndTVShowModel
struct MovieAndTVShowModel: Decodable{
    let page: Int?
    let results: [MovieAndTVShowsModelResult]?
    let totalPages, totalResults: Int?
    var collectionTitle: String?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
