//
//  Filters.swift
//  PARADo
//
//  Created by Anthony Cifre on 6/11/23.
//

import Foundation

enum ProjectSortBy: Identifiable, CaseIterable  {
    var id: Self { self }
    case title
    case content
    case createdAt

    var text: String {
        switch self {
        case .title:
            return "Title"
        case .content:
            return "Content"
        case .createdAt:
            return "Created At"
        }
    }
}

enum OrderBy: Identifiable, CaseIterable {
    var id: Self { self }
    case ascending
    case descending

    var text: String {
        switch self {
        case .ascending:
            return "Ascending"
        case .descending:
            return "Descending"
        }
    }
}

enum TaskFilterBy: Identifiable, CaseIterable {
    var id: Self { self }
    case all
    case completed
    case notCompleted

    var text: String {
        switch self {
        case .all:
            return "All"
        case .completed:
            return "Completed"
        case .notCompleted:
            return "Not Completed"
        }
    }
}



