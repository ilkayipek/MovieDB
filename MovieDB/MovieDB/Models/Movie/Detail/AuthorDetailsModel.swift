//
//  AuthorDetailsModel.swift
//  MovieDB
//
//  Created by MacBook on 30.08.2023.
//

import Foundation

// MARK: - AuthorDetailsModel
struct AuthorDetailsModel: Codable {
    let name, username: String?
    let avatarPath: String?
    let rating: Int?

    enum CodingKeys: String, CodingKey {
        case name, username
        case avatarPath = "avatar_path"
        case rating
    }
}
