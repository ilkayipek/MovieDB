//
//  PersonImagesModel.swift
//  MovieDB
//
//  Created by MacBook on 11.09.2023.
//

// MARK: - PersonImagesModel
struct PersonImagesModel: Decodable, FetchResultStatusProtocol {
    let id: Int?
    let profiles: [Profile]?
    var statusCode: Int?
    var statusMessage: String?
    var success: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, profiles
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success
    }
}


