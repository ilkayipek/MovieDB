//
//  PeopleModel.swift
//  MovieDB
//
//  Created by MacBook on 17.02.2024.
//

import Foundation

// MARK: - PeopleModel
struct PeopleModel: Decodable, SearchResultProtocol {
    let page: Int?
    let results: [PersonResultModel]?
    let totalPages, totalResults: Int?
    var collectionTitle: String?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
