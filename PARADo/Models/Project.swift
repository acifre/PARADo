//
//  Project.swift
//  PARADo
//
//  Created by Anthony Cifre on 6/10/23.
//

import Foundation
import SwiftData

@Model final class Project {
    @Attribute(.unique) var id: String?
    var title: String?
    var content: String
    var dateCreated: Date?
    var dateFinished: Date?
    var dateDue: Date?
    var category: String
    @Attribute(.transient) var isComplete: Bool


    @Relationship(.cascade, inverse: \Task.project) var tasks: [Task]
    
    init(title: String = "", content: String = "") {
        self.id = UUID().uuidString
        self.title = title
        self.content = content
        self.dateCreated = Date.now
        self.tasks = []
        self.category = "Inbox"
        self.isComplete = false

    }
}

extension Project {

    var displayTitle: String {
        title ?? "Untitled Project"
    }

    var displayContent: String {
        content 
    }

    var displayDateCreated: Date {
        dateCreated ?? Date.now
    }

    var displayDateFinished: Date {
        dateFinished ?? Date.now
    }

    var displayDateDue: Date {
        dateDue ?? Date.now
    }

    
}

enum ProjectCategory: String, Codable, CaseIterable  {

    case inbox, current, area, archive

    var text: String {
        switch self {
        case .inbox:
            return "Inbox"
        case .current:
            return "Current"
        case .area:
            return "Area"
        case .archive:
            return "Archive"
        }
    }
}
