//
//  UILabel+Extension.swift
//  MovieDB
//
//  Created by MacBook on 16.08.2023.
//

import UIKit.UILabel

extension UILabel {
    func setIcon(iconName: IconName, colorName: IconColor, scale: CGFloat, startText: String?, andText: String?) {
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

extension UILabel {
    func numberOfLinesRequired() -> Int {
        guard let labelText = self.text else {
            return 0
        }
        
        let font = self.font!
        let labelWidth = self.frame.size.width
        
        let maxSize = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
        let labelRect = (labelText as NSString).boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        let numberOfLines = Int(ceil(labelRect.size.height / font.lineHeight))
        
        return numberOfLines
    }
}
