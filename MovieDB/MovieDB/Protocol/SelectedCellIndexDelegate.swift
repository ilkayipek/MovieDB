//
//  MovieTableViewCellDelegate.swift
//  MovieDB
//
//  Created by MacBook on 2.08.2023.
//

protocol SelectedCellIndexDelegate: AnyObject {
    func selectedId(id: Int, mediaType: MediaType)
    func selectedIdMovie(id: Int)
    func selectedIdTvShow(id: Int)
    func selectedIdPerson(id: Int)
}

extension SelectedCellIndexDelegate {
    func selectedId(id: Int, mediaType: MediaType) {}
    func selectedIdMovie(id: Int) {}
    func selectedIdTvShow(id: Int) {}
    func selectedIdPerson(id: Int) {}
}
