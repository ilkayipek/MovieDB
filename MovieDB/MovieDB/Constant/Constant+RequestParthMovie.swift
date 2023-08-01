//
//  Constant+RequestParthMovie.swift
//  MovieDB
//
//  Created by MacBook on 1.08.2023.
//

extension Constant {
    enum RequestPathMovie: String {
        case popularMovie = "/3/movie/popular?api_key="
        case trendDayMovie = "/3/trending/movie/day?api_key="
        
        static func popularMoviesPath() -> String {
            return "\(popularMovie.rawValue)\(Constant.shared.apiKey)"
        }
        static func trendDayMoviesPath() -> String {
            return "\(trendDayMovie.rawValue)\(Constant.shared.apiKey)"
        }
    }
}
