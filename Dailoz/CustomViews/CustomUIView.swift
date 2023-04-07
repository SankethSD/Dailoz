//
//  CustomUIView.swift
//  Dailoz
//
//  Created by Bitcot Technologies on 23/03/23.
//

import UIKit

class CustomView: UIView{
    
    @IBInspectable var cornerRadius: CGFloat = 5{
        didSet{
            layoutSubviews()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1{
        didSet{
            layoutSubviews()
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.systemGray.withAlphaComponent(0.5){
        didSet{
            layoutSubviews()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 3{
        didSet{
            layoutSubviews()
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = .zero{
        didSet{
            layoutSubviews()
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.6{
        didSet{
            layoutSubviews()
        }
    }
    
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
    }
    
}

