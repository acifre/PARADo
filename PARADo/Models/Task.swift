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

    enum TaskPriority: Int {
        case low = 0
        case medium = 1
        case high = 2
    }

    @Attribute(.unique) var id: String?
    var name: String
    var note: String
    var dateCreated: Date
    var dateDue: Date?
//    var dateFinished: Date?

    var isImportant: Bool
    var isComplete: Bool
    var hasDueDate: Bool
    var hasProject: Bool

    @Relationship var project: Project?
    
    init(name: String = "", note: String = "") {
        self.id = UUID().uuidString
        self.name = name
        self.note = note
        self.dateCreated = .now
        self.dateDue = nil
        self.isImportant = false
        self.isComplete = false
        self.hasDueDate = false
        self.hasProject = false

    }
    
}
