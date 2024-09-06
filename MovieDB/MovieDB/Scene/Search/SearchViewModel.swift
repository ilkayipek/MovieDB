//
//  SearchViewModel.swift
//  MovieDB
//
//  Created by MacBook on 6.02.2024.
//

import Foundation

class SearchViewModel: BaseViewModel {
    let dispatchGroup = DispatchGroup()
    
    func fetchMovieResults(queryString: String,_ closure: @escaping(MovieAndTVShowModel?) -> Void) -> Void {
        startDispatchGroup()
        let path = Constant.RequestPathMovie.searchCollectionPath(collection: .movie, querySting: queryString, page: 1)
        
        Network.shared.getRequestV3(urlPath: path) {[weak self] (data:Result<MovieAndTVShowModel, Error>) in
            guard let self else {return}
            
            switch data {
            case .success(var data):
                data.collectionTitle = NSLocalizedString("Movies", comment: "")
                data.mediaType = .movie
                if var results = data.results, !results.isEmpty {
                    closure(data)
                } else {
                    closure(nil)
                }
            case .failure(let error):
                closure(nil)
                print(error.localizedDescription)
            }
            self.dispatchGroup.leave()
        }
    }
    
    func fetchTvShowResults(queryString: String,_ closure: @escaping(MovieAndTVShowModel?) -> Void) -> Void {
        dispatchGroup.enter()
        let path = Constant.RequestPathMovie.searchCollectionPath(collection: .tvShow, querySting: queryString, page: 1)
        
        Network.shared.getRequestV3(urlPath: path) {[weak self] (data:Result<MovieAndTVShowModel, Error>) in
            guard let self else {return}
            
            switch data {
            case .success(var data):
                data.collectionTitle = NSLocalizedString("TV Shows", comment: "")
                data.mediaType = .tv
                if let results = data.results, !results.isEmpty {
                    closure(data)
                } else {
                    closure(nil)
                }
            case .failure(let error):
                closure(nil)
                print(error.localizedDescription)
            }
            self.dispatchGroup.leave()
        }
    }
    
    func fetchPeopleResults(queryString: String,_ closure: @escaping(PeopleModel?) -> Void) -> Void {
        dispatchGroup.enter()
        let path = Constant.RequestPathMovie.searchCollectionPath(collection: .people, querySting: queryString, page: 1)
        
        Network.shared.getRequestV3(urlPath: path) {[weak self] (data:Result<PeopleModel, Error>) in
            guard let self else {return}
            
            switch data {
            case .success(var data):
                data.collectionTitle = NSLocalizedString("People", comment: "")
                if let results = data.results, !results.isEmpty {
                    closure(data)
                } else {
                    closure(nil)
                }
            case .failure(let error):
                closure(nil)
                print(error.localizedDescription)
            }
            self.dispatchGroup.leave()
        }
    }
    
    //grouping start
    func startDispatchGroup() {
        dispatchGroup.enter()
        gradientLoagingTabAnimation?.startAnimations()
    }
    
    //grouping closed
    func closeDispetchGroup(_ closure: @escaping()->Void) -> Void {
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self else {return}
            closure()
            self.gradientLoagingTabAnimation?.stopAnimations()
        }
    }
}
