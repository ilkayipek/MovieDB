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
        case movieDetail = "/3/movie/"
        case translationMaviePath = "/3/movie"
        case languagePath = "&language="
        case apiKeyPath = "?api_key="
        case credits = "/credits"

        
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
        
        static func detailOriginalMoviePath(movieId: Int) -> String {
            return "\(movieDetail.rawValue)\(movieId)\(apiKeyPath.rawValue)\(Constant.shared.apiKey)"
        }
        
        static func translationMoviePath(movieId: Int, language: Language) -> String {
            let apiKey = Constant.shared.apiKey
            return "\(translationMaviePath.rawValue)/\(movieId)\(apiKeyPath.rawValue)\(apiKey)\(languagePath.rawValue)\(language.rawValue)"
        }
        
        static func castPath(movieId: Int) -> String {
            return "\(movieDetail.rawValue)\(movieId)\(credits.rawValue)"
        }
    }
}
