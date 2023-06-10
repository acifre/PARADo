//
//  Task.swift
//  PARADo
//
//  Created by Anthony Cifre on 6/10/23.
//

import Foundation
import SwiftData

@Model
class Task {
    @Attribute(.unique) var id: String?
    var name: String
    var content: String
    var dateCreated: Date
    var dateFinished: Date?
    
    @Attribute(.transient) var isComplete: Bool = false
    
    @Relationship var project: Project?

    
    init(id: String, name: String, content: String) {
        self.id = id
        self.name = name
        self.content = content
        self.dateCreated = Date()
    }
    
}
