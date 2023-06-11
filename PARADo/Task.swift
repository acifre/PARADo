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
    var note: String
    var dateCreated: Date
    var dateFinished: Date?
    
    @Attribute(.transient) var isComplete: Bool = false
    
    @Relationship var project: Project?

    
    init(id: String, name: String, note: String) {
        self.id = id
        self.name = name
        self.note = note
        self.dateCreated = Date()
    }
    
}
