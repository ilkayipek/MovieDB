//
//  MovieTableViewCellDelegate.swift
//  MovieDB
//
//  Created by MacBook on 2.08.2023.
//

protocol SelectedIndexDelegate: AnyObject {
    func selectedId(movieId: Int, mediaType: MediaType)
}
