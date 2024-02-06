//
//  MovieCollections.swift
//  MovieDB
//
//  Created by MacBook on 30.01.2024.
//

import Foundation

extension Constant.RequestPathMovie {
    enum MovieCollectionsPath: String {
        case nowPlayingMovie = "now_playing"
        case popularMovie = "popular"
        case topRatedMovie = "top_rated"
        case upcomingMovie = "upcoming"
        case trendingMovies = "/3/trending/movie/"
        
        init(collection: MovieCollections) {
            switch collection {
            case .nowPlaying:
                self = .nowPlayingMovie
            case .popular:
                self = .popularMovie
            case .topRated:
                self = .topRatedMovie
            case .upcoming:
                self = .upcomingMovie
            }
        }
    }
}

