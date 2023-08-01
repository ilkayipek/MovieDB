//
//  MovieModelProtocol.swift
//  MovieDB
//
//  Created by MacBook on 1.08.2023.
//

protocol MovieModelProtocol {
    var collectionTitle: String? {get}
    var page: Int? { get }
    var results: [MovieResult]? { get }
    var statusCode: Int? { get }
    var statusMessage: String? { get }
    var success: Bool? { get }
}
