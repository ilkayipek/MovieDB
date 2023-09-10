//
//  PeopleDetailModel.swift
//  MovieDB
//
//  Created by MacBook on 10.09.2023.
//

import Foundation

// MARK: - PeopleDetailModel
struct PeopleDetailModel: Decodable, FetchResultStatusProtocol {
    let adult: Bool?
    let alsoKnownAs: [String]?
    let biography, birthday: String?
    let deathday: String?
    let gender: Int?
    let homepage: String?
    let id: Int?
    let imdbid, knownForDepartment, name, placeOfBirth: String?
    let popularity: Double?
    let profilePath: String?
    var statusCode: Int?
    var statusMessage: String?
    var success: Bool?

    enum CodingKeys: String, CodingKey {
        case adult
        case alsoKnownAs = "also_known_as"
        case biography, birthday, deathday, gender, homepage, id
        case imdbid = "imdb_id"
        case knownForDepartment = "known_for_department"
        case name
        case placeOfBirth = "place_of_birth"
        case popularity
        case profilePath = "profile_path"
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success
    }
}
