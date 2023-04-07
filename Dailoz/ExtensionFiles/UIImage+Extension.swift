//
//  UIImage+Extension.swift
//  Dailoz
//
//  Created by Bitcot Technologies on 27/03/23.
//

import UIKit

typealias AppAssetIcon = UIImage.appAssetIcon

extension UIImage{
    
    struct appAssetIcon{
        static let backIcon = UIImage(named: "backIcon")
        static let tickIcon = UIImage(named: "tickIcon")
        static let optionsIcon = UIImage(named: "optionsIcon")
        static let settingsIcon = UIImage(named: "settingsIcon")
        static let logoutIcon = UIImage(named: "logoutIcon")
        static let personalIcon = UIImage(named: "personalIcon")
        static let workIcon = UIImage(named: "workIcon")
        static let meetingIcon = UIImage(named: "meetingIcon")
        static let eventsIcon = UIImage(named: "eventsIcon")
        static let lockIcon = UIImage(named: "lockIcon")
        static let createBoard = UIImage(named: "createBoardIcon")
    }
    
}
