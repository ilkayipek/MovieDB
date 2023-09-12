//
//  Constant+RequestParthMovie.swift
//  MovieDB
//
//  Created by MacBook on 1.08.2023.
//https://api.themoviedb.org/3/person/{person_id}
//https://api.themoviedb.org/3/person/{person_id}/external_ids
//https://api.themoviedb.org/3/person/{person_id}/images

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
        case trailerVideoWeb = "https://www.youtube.com/watch?v="
        case trailerVideoApp = "youtube://watch?v="
        case credits = "/credits"
        case thumbnailUrl = "https://img.youtube.com/vi/"
        case vieos = "/videos"
        case similar = "/similar"
        case reviews = "/reviews"
        case personDetail = "/3/person/"
        case personExternalIDsPath = "/external_ids"
        case personImages = "/images"
        
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
        
        static func trailerVideoUrlWeb(key: String) -> String {
            return "\(trailerVideoWeb.rawValue+key)"
        }
        
        static func trailerVideoUrlApp(key: String) -> String {
            return "\(trailerVideoApp.rawValue+key)"
        }
        
        static func trailerThumbnailUrl(key: String?) -> URL? {
            if let url = URL(string: "\(thumbnailUrl.rawValue)\(key ?? "")/0.jpg") {
                return url
            } else {
                return nil
            }
        }
        
        static func trailerPath(movieId: Int) -> String {
            return "\(movieDetail.rawValue)\(movieId)\(vieos.rawValue)"
        }
        
        static func similarMovies(movieId: Int) -> String {
            return "\(movieDetail.rawValue)\(movieId)\(similar.rawValue)"
        }
        
        static func reviewsMoviePath(movieId: Int) -> String {
            return "\(movieDetail.rawValue)\(movieId)\(reviews.rawValue)"
        }
        
        static func personDetailPath(personId: Int) -> String {
            return "\(personDetail.rawValue)\(personId)"
        }
        
        static func externalIDsPath(personId: Int) -> String {
            return "\(personDetail.rawValue)\(personId)\(personExternalIDsPath.rawValue)"
        }
        
        static func personImagesPath(personId: Int) -> String {
            return "\(personDetail.rawValue)\(personId)\(personImages.rawValue)"
        }
    }
}
