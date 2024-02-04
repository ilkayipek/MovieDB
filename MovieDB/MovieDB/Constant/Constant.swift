//
//  Constant.swift
//  MovieDB
//
//  Created by MacBook on 1.08.2023.
//

import Foundation

final class Constant {
    static let shared: Constant = Constant()
    let apiKey: String = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String
    let baseUrl: String = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as! String
    var defaultLanguage = Language.en.rawValue
}

