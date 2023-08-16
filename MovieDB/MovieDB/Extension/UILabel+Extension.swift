//
//  UILabel+Extension.swift
//  MovieDB
//
//  Created by MacBook on 16.08.2023.
//

import UIKit.UILabel

extension UILabel {
    func setIcon(iconName: IconeName, colorName: IconeColor, scale: CGFloat, startText: String?, andText: String?) {
        let imageAttachment = NSTextAttachment()

        if let iconImage = UIImage(systemName: iconName.rawValue)?.withTintColor(UIColor(named: colorName.rawValue) ?? .gray) {
            let newSize = CGSize(width: iconImage.size.width * scale, height: iconImage.size.height * scale)
            UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
            iconImage.draw(in: CGRect(origin: .init(x: -1,y: 1), size: newSize))
            let scaledIconImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            imageAttachment.image = scaledIconImage
        }

        let fullString = NSMutableAttributedString(string: startText ?? "")
        fullString.append(NSAttributedString(attachment: imageAttachment))
        fullString.append(NSAttributedString(string: andText ?? ""))
        self.attributedText = fullString
    }
}
