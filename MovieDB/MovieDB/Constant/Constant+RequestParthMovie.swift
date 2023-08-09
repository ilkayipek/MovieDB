//
//  Constant+RequestParthMovie.swift
//  MovieDB
//
//  Created by MacBook on 1.08.2023.
//

import Foundation

extension Constant {
    enum RequestPathMovie: String {
        case popularMovie = "/3/movie/popular?api_key="
        case trendDayMovie = "/3/trending/movie/day?api_key="
        case imageBaseUrlPath = "https://image.tmdb.org/t/p/"
        
        static func popularMoviesPath() -> String {
            return "\(popularMovie.rawValue)\(Constant.shared.apiKey)"
        }
        
        static func trendDayMoviesPath() -> String {
            return "\(trendDayMovie.rawValue)\(Constant.shared.apiKey)"
        }
        
        static func imageUrl(imageSize: ImageSizeSections, path: String?) -> URL? {
            guard let path else { return nil }
            if let url = URL(string: "\(imageBaseUrlPath.rawValue)\(imageSize.rawValue)\(path)") {
                return url
            } else { return nil }
        }
    }
}
