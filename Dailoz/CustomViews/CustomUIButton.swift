//
//  CustomUIButton.swift
//  Dailoz
//
//  Created by bitcor on 22/03/23.
//

import UIKit
class RoundedButtonWithBorder: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 5 {
        didSet {
            layoutSubviews()
        }
    }
    
    
    @IBInspectable var borderColor: UIColor =
    UIColor.black.withAlphaComponent(0.4) {
        didSet {
            layoutSubviews()
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0.4 {
        didSet {
            layoutSubviews()
        }
    }
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet {
            layoutSubviews()
        }
    }
    @IBInspectable var shadowOpacity: Float = 0.0 {
        didSet{
            layoutSubviews()
        }
    }
    
    @IBInspectable var shadowOffSet: CGSize = .zero {
        didSet {
            layoutSubviews()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffSet
    }
    
}


