//
//  PersonResult.swift
//  MovieDB
//
//  Created by MacBook on 17.02.2024.
//

import Foundation

// MARK: - PersonResult
struct PersonResultModel: Decodable {
    let adult: Bool?
    let gender, id: Int?
    let knownForDepartment: String?
    let name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let knownFor: [KnownForPerson]?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case knownFor = "known_for"
    }
}
