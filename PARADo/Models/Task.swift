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

    static var exampleTasks: [Task] {
        [
            Task(name: "Watering plants", note: "This is an example task."),
            Task(name: "Taking the trash out", note: "This is an example task."),
            Task(name: "Writing intro to paper", note: "This is an example task."),
            Task(name: "Taking dog out", note: "This is an example task."),
            Task(name: "Change out lightbulb", note: "This is an example task."),
            Task(name: "Do laundry", note: "This is an example task."),
            Task(name: "Get ice cream", note: "This is an example task."),
            Task(name: "Make a grocery list", note: "This is an example task."),
            Task(name: "Change out air filter", note: "This is an example task."),
            Task(name: "Call mom", note: "This is an example task.")
        ]
    }

}

