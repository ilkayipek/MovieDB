//
//  UIViewController+Extension.swift
//  MovieDB
//
//  Created by MacBook on 15.08.2023.
//

import UIKit.UIViewController

extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T(nibName: String(describing: self), bundle: nil)
        }
        return instantiateFromNib()
    }
}


