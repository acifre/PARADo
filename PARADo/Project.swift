//
//  Project.swift
//  PARADo
//
//  Created by Anthony Cifre on 6/10/23.
//

import Foundation
import SwiftData

@Model
class Project {
    @Attribute(.unique) var id: String?
    var title: String
    var content: String
    var dateCreated: Date
    var dateFinished: Date?
    
    @Relationship(inverse: \Task.project) var tasks: [Task]
    
    
    init(id: String, title: String, content: String, tasks: [Task]) {
        self.id = id
        self.title = title
        self.content = content
        self.dateCreated = Date()
        self.tasks = tasks
    }
    
}

//@Model
//class ProjectType {
//    
//}
