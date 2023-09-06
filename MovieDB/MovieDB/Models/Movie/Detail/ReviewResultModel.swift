//
//  ReviewResultModel.swift
//  MovieDB
//
//  Created by MacBook on 30.08.2023.
//

import Foundation

// MARK: - ReviewResultModel
struct ReviewResultModel: Codable {
    let author: String?
    let authorDetails: AuthorDetailsModel?
    let content, createdAt, id, updatedAt: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
}
