//
//  Constants.swift
//  Dailoz
//
//  Created by Bitcot Technologies on 22/03/23.
//

import Foundation

typealias User = Constants.User
typealias CurrentUser = Constants.CurrentUser
typealias TableViewCellIdentifier = Constants.TableViewCellIdentifier
typealias CollectionViewCellIdentifiers = Constants.CollectionViewCellIdentifiers
typealias ViewControllerIdentifiers = Constants.ViewControllerIdentifiers
typealias NibNames = Constants.NibNames

struct Constants{
    
    struct User {
        // Key used to store bool value for automatically going to home page
        static var isLoggedIn = "isLoggedIn"
        
        // Key used to store the current userName
        static var currUserName = "currUserName"
    }
    
    struct CurrentUser: Codable{
        
        var userName: String?
        var email: String?
        var password: String?
        var boardData: [BoardModel]?
        var tagData: [String]?
        var tasks: [TaskModel]?
        
        init(userName: String? = nil, email: String? = nil, password: String? = nil, boardData: [BoardModel]? = nil, tagData: [String]? = nil, tasks: [TaskModel]? = nil) {
            self.userName = userName
            self.email = email
            self.password = password
            self.boardData = boardData
            self.tagData = tagData
            self.tasks = tasks
        }
        
    }
    
    struct TableViewCellIdentifier{
        static let homePageCell = "HomePageTableViewCell"
        static let tasksCell = "TasksDateWiseTableViewCell"
        
    }
    
    struct CollectionViewCellIdentifiers{
        
        static let boardCell = "BoardCollectionViewCell"
        static let tagsCell = "TagsCollectionViewCell"
        static let dateCell = "DateCollectionViewCell"
        static let tasksCell = "TasksTimeWiseCollectionViewCell"
        
    }
    
    struct ViewControllerIdentifiers{
        
        static let splashVC = "SplashViewController"
        static let loginVC = "LoginViewController"
        static let homeVC = "HomeViewController"
        static let profileVC = "ProfileViewController"
        static let addTaskVC = "AddTaskViewController"
        static let settingsVC = "SettingsViewController"
        static let tasksVC = "TasksViewController"
        static let homeTaskVC = "HomePageTasksViewController"
        
    }
    
    struct NibNames{
        static let createBoardVC = "CreateBoardViewController"
        static let datePickerVC = "DatePickerViewController"
        static let addTagsVC = "AddTagsViewController"
        static let editTimeVC = "EditTimeViewController"
        static let languageVC = "LanguageViewController"
        static let deleteAccountVC = "DeleteAccountViewController"
        static let logOutVC = "LogoutViewController"
        
    }
    
}
