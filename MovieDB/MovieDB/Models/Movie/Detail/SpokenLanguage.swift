//
//  SpokenLanguage.swift
//  MovieDB
//
//  Created by MacBook on 16.08.2023.
//

// MARK: - ProductionCountry
struct SpokenLanguage: Decodable {
    let iso639_1, name: String?

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case name
    }
}
