//
//  HomeViewModel.swift
//  MovieDB
//
//  Created by MacBook on 1.08.2023.
//

import Foundation

class HomeViewModel: BaseViewModel {
    let dispatchGroup = DispatchGroup()
    
    func getTrendingAll(dayOrWeek: DayOrWeek, _ closure: @escaping(MovieAndTVShowModel?) -> Void) {
        dispatchGroup.enter()
        
        let trendAllPath = Constant.RequestPathMovie.trendingAll(dayOrWeek: dayOrWeek)
        
        Network.shared.getRequestV3(urlPath: trendAllPath) {[weak self] (result: Result<MovieAndTVShowModel?, Error>) in
            guard let self else {return}
            
            switch result {
            case .success(let data):
                if var data = data, !(data.results?.isEmpty ?? true) {
                    data.collectionTitle = NSLocalizedString("Trending", comment: "")
                    closure(data)
                } else {
                    closure(nil)
                }
            case .failure(let error):
                print("MOVİE AND TV MODEL FETCH ERROR: \(error.localizedDescription)")
                closure(nil)
            }
            self.dispatchGroup.leave()
        }
    }
    
    func getFreeToWatch(_ mediaType: MediaType, _ closure: @escaping(MovieAndTVShowModel?) -> Void) {
        dispatchGroup.enter()
        
        let path = Constant.RequestPathMovie.freeToWatchPath(mediaType: mediaType)
        
        Network.shared.getRequestV3(urlPath: path) {[weak self] (result: Result<MovieAndTVShowModel?, Error>) in
            guard let self else {return}
            
            switch result {
            case .success(let data):
                if var data = data, !(data.results?.isEmpty ?? true) {
                    switch mediaType {
                    case .movie:
                        data.collectionTitle = NSLocalizedString("Free To Watch Movie", comment: "")
                        data.mediaType = .movie
                    case .tv:
                        data.collectionTitle = NSLocalizedString("Free To Watch Tv Show", comment: "")
                        data.mediaType = .tv
                    }
                    closure(data)
                } else {
                    closure(nil)
                }
            case .failure(let error):
                print("MOVİE AND TV MODEL FETCH ERROR: \(error.localizedDescription)")
                closure(nil)
            }
            self.dispatchGroup.leave()
        }
    }
    
    
    //grouping  closed 
    func closeDispatchGroup(_ closure: @escaping() ->Void) -> Void {
        dispatchGroup.notify(queue: .main) {
            closure()
        }
    }
}
