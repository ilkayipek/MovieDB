//
//  AllListCollectionViewModel.swift
//  MovieDB
//
//  Created by MacBook on 26.01.2024.
//

import Foundation

class AllListCollectionViewModel: BaseViewModel {
    
    var page = 1
    var isLoadData = true
    let dispatchGroup = DispatchGroup()
    var resultPages = [MovieAndTVShowsModelResult]()
    
    func fetchAllMoviePageResults(collection: MovieCollections, closure: @escaping ([MovieAndTVShowsModelResult]?) ->Void) -> Void{
        startDispatchGroup()
        
//        load next page?
        if(isLoadData) {
            let path = Constant.RequestPathMovie.movieCollectionPath(collection: collection, page: page)
            
            Network.shared.getRequestV3(urlPath: path) {[weak self] (result:Result<MovieAndTVShowModel?, Error>) in
                guard let self else {return}
                
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let data):
                    if let result = data?.results, !result.isEmpty {
                        self.resultPages = resultPages + result
                        self.dispatchGroup.leave()
                        self.closeDispetchGroup()
                        closure(resultPages)
                    } else {
                        isLoadData = false
                    }
                    self.page = page + 1
                }
        }
        }
          
        
    }
    
    //grouping and animation start func
    func startDispatchGroup() {
        dispatchGroup.enter()
        gradientLoagingTabAnimation?.startAnimations()
    }
    
    
    //grouping and animation stop func
    func closeDispetchGroup() -> Void {
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self else {return}
            self.gradientLoagingTabAnimation?.stopAnimations()
        }
    }
}
