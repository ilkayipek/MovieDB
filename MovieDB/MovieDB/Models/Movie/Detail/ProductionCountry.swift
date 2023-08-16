//
//  ProductionCountry.swift
//  MovieDB
//
//  Created by MacBook on 16.08.2023.
//

// MARK: - ProductionCountry

struct ProductionCountry: Decodable {
    let iso3166_1, name: String?

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}
