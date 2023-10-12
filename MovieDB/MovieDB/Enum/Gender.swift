//
//  Gender.swift
//  MovieDB
//
//  Created by MacBook on 10.09.2023.
//

enum Gender: Int, CustomStringConvertible {
    case unspecified = 0
    case female = 1
    case male = 2
    
    init?(rawValue: Int) {
            switch rawValue {
            case 0:
                self = .unspecified
            case 1:
                self = .female
            case 2:
                self = .male
            default:
                return nil
            }
        }
    
    var description: String {
        switch self {
        case .unspecified:
            return "Unspecified"
        case .male:
            return "Male"
        case .female:
            return "Female"
        }
    }
}
