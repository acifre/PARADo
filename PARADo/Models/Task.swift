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
    var dateDue: Date?
//    var dateFinished: Date?
    
    @Attribute(.transient) var isComplete: Bool = false
    @Attribute(.transient) var hasDueDate: Bool = false
    @Attribute(.transient) var hasProject: Bool = false

    @Relationship var project: Project?
    
    init(name: String, note: String) {
        self.id = UUID().uuidString
        self.name = name
        self.note = note
        self.dateCreated = Date()

    }
    
}
