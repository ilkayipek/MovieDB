//
//  Network.swift
//  MovieDB
//
//  Created by MacBook on 25.07.2023.
//

import UIKit
import Alamofire

class Network {
    static let shared = Network()
    
    private init() {
    }
    
    private func getUrl(urlPath: String) -> URL? {
        if let baseUrl = Bundle.main.object(forInfoDictionaryKey: "BASE_URL")  as? String {
            guard let url = URL(string: baseUrl) else {return nil}
            let blogURL = URL(string: urlPath, relativeTo: url)!
            return blogURL
        }
        return nil
    }
    
    private func getAuthTokenAndContentType() -> (String?, String?) {
        if let authToken = Bundle.main.object(forInfoDictionaryKey: "AUTH_TOKEN") as? String, let contentType = Bundle.main.object(forInfoDictionaryKey: "CONTENT_TYPE") as? String {
            return (authToken, contentType)
        } else {
            return (nil, nil)
        }
    }
    
    func postAuthV4<T: Encodable, U: Decodable>(urlPath: String, parameters: T, method: HTTPMethod, completion: @escaping (Result<U, Error>) -> Void) {
        guard let url = getUrl(urlPath: urlPath) else {return}
        
        var headers = HTTPHeaders()
        
        AF.request(url,
                   method: method,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default,
                   headers: headers).response { response in
            debugPrint(response)
        }.responseDecodable(of: U.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getRequestV3<T: Decodable>(urlPath: String, completion: @escaping (Result<T, Error>) -> Void) {
        let (authToken, contentType) = getAuthTokenAndContentType()
        
        guard let authToken else {return}
        guard let contentType else {return}
        guard let url = getUrl(urlPath: urlPath) else {return}
        
        var headers = HTTPHeaders()
        headers.add(name: AuthV4Headers.contentType.rawValue, value: contentType)
        headers.add(name: AuthV4Headers.authorization.rawValue, value: authToken)
            
        AF.request(url, headers: headers).response {  response  in
            debugPrint(response)
        }.responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func postRequestV3<T: Encodable, U: Decodable>(urlpath: String, method: HTTPMethod, parameters: T, completed: @escaping(Result<U, Error>) -> Void) {
        guard let url = getUrl(urlPath: urlpath) else {return}
        AF.request(
            url,
            method: method,
            parameters: parameters,
            encoder: JSONParameterEncoder.default).response { respose in
                debugPrint(respose)
        }.responseDecodable(of: U.self) { respose in
                switch respose.result {
                case .success(let data):
                    completed(.success(data))
                case .failure(let error):
                    completed(.failure(error))
                }
        }
    }
}
