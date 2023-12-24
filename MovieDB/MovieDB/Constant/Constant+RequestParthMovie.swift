//
//  Constant+RequestParthMovie.swift
//  MovieDB
//
//  Created by MacBook on 1.08.2023.
//https://api.themoviedb.org/3/person/{person_id}
//https://api.themoviedb.org/3/person/{person_id}/external_ids
//https://api.themoviedb.org/3/person/{person_id}/images
//https://api.themoviedb.org/3/trending/all/{time_window}
//https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&watch_region=TR&with_watch_monetization_types=free

import Foundation

extension Constant {
    enum RequestPathMovie: String {
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
        case trendingAll = "/3/trending/all/"
        case freeToWatchMovie = "/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&watch_region=TR&with_watch_monetization_types=free"
        case freeToWatchTvShow = "/3/discover/tv?include_adult=false&include_null_first_air_dates=false&language=en-US&page=1&sort_by=popularity.desc&watch_region=TR&without_watch_providers=free"
        case nowPlayingNMovie = "/3/movie/now_playing"
        case popularMovie = "/3/movie/popular"
        case topRatedMovie = "/3/movie/top_rated"
        case upcomingMovie = "/3/movie/upcoming"
        
        static func upcomingMoviePath() -> String {
            return upcomingMovie.rawValue
        }
        
        static func topRatedMoviePath() -> String {
            return topRatedMovie.rawValue
        }
        
        static func nowPlayingMoviePath() -> String {
            return nowPlayingNMovie.rawValue
        }
        
        static func freeToWatchPath(mediaType: MediaType) -> String {
            switch mediaType {
            case .movie:
                return freeToWatchMovie.rawValue
            case .tv:
                return freeToWatchTvShow.rawValue
            }
        }
        
        static func trendingAll(dayOrWeek: DayOrWeek) -> String {
            return "\(trendingAll.rawValue + dayOrWeek.rawValue)"
        }
        
        static func popularMoviesPath() -> String {
            return "\(popularMovie.rawValue)"
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
