//
//  CastModel.swift
//  MovieDB
//
//  Created by MacBook on 20.08.2023.
//

// MARK: - Cast
struct CastModel: Codable {
    let adult: Bool?
    let gender, id: Int?
    let name, originalName, knownForDepartment: String?
    let popularity: Double?
    let profilePath: String?
    let castid: Int?
    let character, creditid: String?
    let order: Int?
    let job, department: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castid = "cast_id"
        case character
        case creditid = "credit_id"
        case order, department, job
    }
}
