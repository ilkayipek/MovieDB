//
//  Constant+RequestPath+SearchCollections.swift
//  MovieDB
//
//  Created by MacBook on 8.02.2024.
//

extension Constant.RequestPathMovie {
    enum SearchCollectionsPath: String {
        case movie = "movie?"
        case tvShow = "tv?"
        case people = "person?"
        
        init(collection: SearchCollection) {
            switch collection {
            case .movie :
                self = .movie
            case .tvShow :
                self = .tvShow
            case .people :
                self = .people
            }
        }
    }
}
