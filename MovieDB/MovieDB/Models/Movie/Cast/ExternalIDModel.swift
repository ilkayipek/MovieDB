//
//  ExternalIDModel.swift
//  MovieDB
//
//  Created by MacBook on 10.09.2023.
//

import Foundation

// MARK: - ExternalIDModel
struct ExternalIDModel: Decodable, FetchResultStatusProtocol {
    let id: Int?
    let freebaseMid, freebaseid, imdbid: String?
    let tvrageid: Int?
    let wikidataid, facebookid, instagramid, tiktokid: String?
    let twitterid: String?
    let youtubeid: String?
    var statusCode: Int?
    var statusMessage: String?
    var success: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case freebaseMid = "freebase_mid"
        case freebaseid = "freebase_id"
        case imdbid = "imdb_id"
        case tvrageid = "tvrage_id"
        case wikidataid = "wikidata_id"
        case facebookid = "facebook_id"
        case instagramid = "instagram_id"
        case tiktokid = "tiktok_id"
        case twitterid = "twitter_id"
        case youtubeid = "youtube_id"
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success
    }
}
