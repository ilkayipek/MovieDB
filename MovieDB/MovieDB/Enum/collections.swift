//
//  collections.swift
//  MovieDB
//
//  Created by MacBook on 31.01.2024.
//

import Foundation

enum MovieCollections: String, Decodable {
    case nowPlaying = "Now Playing"
    case upcoming = "Upcoming"
    case popular = "Popular"
    case topRated = "Top Rated"
}
