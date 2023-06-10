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
    var description: String
    var dateCreated: Date
    var dateFinished: Date?
    
    @Relationship(inverse: \Task.project) var tasks: [Task]
    
    
    init(id: String? = nil, title: String, description: String, tasks: [Task]) {
        self.id = id
        self.title = title
        self.description = description
        self.dateCreated = Date()
        self.tasks = tasks
    }
    
}

//@Model
//class ProjectType {
//    
//}
