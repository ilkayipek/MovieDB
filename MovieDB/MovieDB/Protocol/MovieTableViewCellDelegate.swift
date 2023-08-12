//
//  MovieTableViewCellDelegate.swift
//  MovieDB
//
//  Created by MacBook on 2.08.2023.
//

protocol MovieTableViewCellDelegate: AnyObject {
    func selectedId(movieId: Int)
}
