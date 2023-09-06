//
//  ReviewViewModel.swift
//  MovieDB
//
//  Created by MacBook on 30.08.2023.
//

import Foundation

// MARK: - ReviewModel
struct ReviewModel: Codable {
    let id, page: Int?
    let results: [ReviewResultModel]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
