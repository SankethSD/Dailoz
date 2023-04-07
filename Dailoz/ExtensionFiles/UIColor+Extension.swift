//
//  UIColor+Extension.swift
//  Dailoz
//
//  Created by Bitcot Technologies on 27/03/23.
//

import UIKit

extension UIColor{
    
    struct AppColors{
        static let lightBlue = UIColor(named: "lightBlue")
        static let lightGreen = UIColor(named:"lightGreen")
        static let lightOrange = UIColor(named:"lightOrange")
        static let lightPurple = UIColor(named:"lightPurple")
        static let lightRed = UIColor(named:"lightRed")
        static let themeBlue = UIColor(named:"themeBlue")
        static let themeGreen = UIColor(named:"themeGreen")
        static let themeOrange = UIColor(named:"themeOrange")
        static let themePurple = UIColor(named:"themePurple")
        static let themeRed = UIColor(named:"themeRed")
        
        
        
    }
    
}

public func getColors() -> [[UIColor]]{
    let colors = [[UIColor.AppColors.themePurple,
                                UIColor.AppColors.lightPurple],
                               [UIColor.AppColors.themeRed, UIColor.AppColors.lightRed],
                               [UIColor.AppColors.themeBlue, UIColor.AppColors.lightBlue],
                  [UIColor.AppColors.themeGreen, UIColor.AppColors.lightGreen]] as! [[UIColor]]
    
    return colors
}

public func getBGColors() -> [UIColor]{
    let colors = [UIColor.AppColors.lightPurple,
                  UIColor.AppColors.lightRed,
                  UIColor.AppColors.lightBlue,
                  UIColor.AppColors.lightGreen] as! [UIColor]
    
    return colors
}

public func getThemeColors() -> [UIColor]{
    let colors = [UIColor.AppColors.themePurple,
                  UIColor.AppColors.themeRed,
                  UIColor.AppColors.themeBlue,
                  UIColor.AppColors.themeGreen] as! [UIColor]
    
    return colors
}
