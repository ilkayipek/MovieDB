//
//  Constant.swift
//  MovieDB
//
//  Created by MacBook on 1.08.2023.
//

import UIKit.UIViewController

final class Constant {
    static let shared: Constant = Constant()
    let apiKey: String = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as! String
    let baseUrl: String = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String
}
