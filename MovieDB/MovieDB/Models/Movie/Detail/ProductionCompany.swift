//
//  ProductionCampany.swift
//  MovieDB
//
//  Created by MacBook on 16.08.2023.
//

// MARK: - ProductionCompany
struct ProductionCompany: Decodable {
    let id: Int?
    let logoPath: String?
    let name, originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}
