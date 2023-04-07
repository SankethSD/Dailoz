//
//  Model.swift
//  Dailoz
//
//  Created by Bitcot Technologies on 28/03/23.
//

import Foundation


struct BoardModel: Codable{
    
    var boardName: String?
    var type: String?
    var tasks: Int?
    
    init(boardName: String? = nil, type: String? = nil, tasks: Int? = nil) {
        self.boardName = boardName
        self.type = type
        self.tasks = tasks
    }
    
}

struct TaskModel: Codable{
    
    var title: String?
    var dateStr: String?
    var date: Date?
    var startTime: String?
    var endTime: String?
    var desc: String?
    var type: String?
    var tags: [String]?
    var category: String?
    
    init(title: String? = nil, dateStr: String? = nil, date: Date? = nil, startTime: String? = nil, endTime: String? = nil, desc: String? = nil, type: String? = nil, tags: [String]? = nil, category: String? = nil) {
        self.title = title
        self.dateStr = dateStr
        self.date = date
        self.startTime = startTime
        self.endTime = endTime
        self.desc = desc
        self.type = type
        self.tags = tags
        self.category = category
    }
    
}
