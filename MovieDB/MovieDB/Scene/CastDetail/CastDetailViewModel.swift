//
//  CastDetailViewModel.swift
//  MovieDB
//
//  Created by MacBook on 6.09.2023.
//

import Foundation

class CastDetailViewModel: BaseViewModel {
    
    func getPersonDetail(personId: Int,_ closure: @escaping(PeopleDetailModel?) -> Void) -> Void {
        let path = Constant.RequestPathMovie.personDetailPath(personId: personId)
        
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
    
    func getPersonExternalIds(personId: Int,_ closure: @escaping(ExternalIDModel?) -> Void) -> Void {
        let path = Constant.RequestPathMovie.externalIDsPath(personId: personId)
        
        Network.shared.getRequestV3(urlPath: path) { (result:Result<ExternalIDModel?, Error>) in
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
