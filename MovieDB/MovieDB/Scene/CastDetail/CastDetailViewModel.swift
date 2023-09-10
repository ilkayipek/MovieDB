//
//  CastDetailViewModel.swift
//  MovieDB
//
//  Created by MacBook on 6.09.2023.
//

import Foundation

class CastDetailViewModel: BaseViewModel {
    
    func getPeopleDetail(peopleId: Int,_ closure: @escaping(PeopleDetailModel?) -> Void) -> Void {
        let path = Constant.RequestPathMovie.personDetailPath(personId: peopleId)
        
        Network.shared.getRequestV3(urlPath: path) { (result:Result<PeopleDetailModel?, Error>) in
            switch result {
            case .success(let data):
                if let data, data.success ?? true {
                    closure(data)
                } else {
                    closure(nil)
                }
            case .failure(let error):
                closure(nil)
                print("ERROR MESSAGE: \(error.localizedDescription)")
            }
        }
    }
}
