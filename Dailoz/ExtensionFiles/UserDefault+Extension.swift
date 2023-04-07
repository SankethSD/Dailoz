//
//  UserDefault+Extension.swift
//  Dailoz
//
//  Created by Bitcot Technologies on 28/03/23.
//

import UIKit

public func checkKey(key: String) -> Bool{
    return UserDefaults.standard.dictionaryRepresentation().keys.contains(key)
}

public func getCurrentUserName() -> String{
    return UserDefaults.standard.string(forKey: User.currUserName) ?? ""
}

public func saveCurrentUserName(userName: String){
    UserDefaults.standard.set(userName, forKey: User.currUserName)
}

public func logoutCurrentUser(){
    UserDefaults.standard.set(false, forKey: User.isLoggedIn)
    UserDefaults.standard.removeObject(forKey: User.currUserName)
}

public func deleteCurrentUser(){
    let userName = getCurrentUserName()
    UserDefaults.standard.set(false, forKey: User.isLoggedIn)
    UserDefaults.standard.removeObject(forKey: userName)
}


