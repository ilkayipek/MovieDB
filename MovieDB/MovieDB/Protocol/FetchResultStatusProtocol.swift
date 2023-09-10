//
//  FetchStatusProtocol.swift
//  MovieDB
//
//  Created by MacBook on 10.09.2023.
//

protocol FetchResultStatusProtocol {
    var statusCode: Int? { get }
    var statusMessage: String? { get }
    var success: Bool? { get }
}
