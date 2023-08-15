//
//  CustomContainerUIView.swift
//  MovieDB
//
//  Created by MacBook on 15.08.2023.
//

import UIKit

@IBDesignable
class CustomContainerUIView: UIView {
    @IBInspectable var cornerRadiusValue: CGFloat = 10.0 {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable var borderColor: UIColor = .black {
        didSet {
            setNeedsLayout()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }

    private func setUpView() {
        layer.cornerRadius = cornerRadiusValue
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        clipsToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = cornerRadiusValue
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
}
