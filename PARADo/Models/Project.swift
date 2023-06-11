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
    
    @Attribute(.transient) var isChecked: Bool = false
    
    @Relationship(.cascade, inverse: \Task.project) var tasks: [Task]
    
    init(title: String, content: String) {
        self.id = UUID().uuidString
        self.title = title
        self.content = content
        self.dateCreated = Date()
        self.tasks = []
    }
}
