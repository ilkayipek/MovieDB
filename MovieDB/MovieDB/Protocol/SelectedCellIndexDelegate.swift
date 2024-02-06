//
//  MovieTableViewCellDelegate.swift
//  MovieDB
//
//  Created by MacBook on 2.08.2023.
//

protocol SelectedCellIndexDelegate: AnyObject {
    func selectedId(id: Int, mediaType: MediaType)
}
