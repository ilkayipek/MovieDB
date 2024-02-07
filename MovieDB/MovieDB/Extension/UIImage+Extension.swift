//
//  UIImage+Extension.swift
//  MovieDB
//
//  Created by MacBook on 6.02.2024.
//

import UIKit

extension UIImage {
    func resize(targetSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
    
    func setSystemIcone(_ icone: IconName) -> UIImage? {
        return UIImage(systemName: icone.rawValue)
    }
    
}

