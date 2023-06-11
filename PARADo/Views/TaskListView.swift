//
//  TaskListView.swift
//  PARADo
//
//  Created by Anthony Cifre on 6/11/23.
//

import SwiftData
import SwiftUI

struct TaskListView: View {
    enum Field {
        case name
        case note
        case project
    }
    @Environment(\.modelContext) private var context
    @Query(sort: \.title) var allProjects: [Project]
    @Query(sort: \.name) var allTasks: [Task]

    @State var newTaskName = ""
    @State var newTaskNote = ""
    @State var newTaskProject: Project?
    @FocusState private var focusedField: Field?


    var body: some View {
        List {
            Section {
                DisclosureGroup("Create Task") {
                    TextField("Task name", text: $newTaskName)
                        .focused($focusedField, equals: .name)

                    TextField("Task description", text: $newTaskNote, axis: .vertical)
                        .focused($focusedField, equals: .note)
                        .lineLimit(2...4)
                    DisclosureGroup("Add to") {
                        if allProjects.isEmpty {
                            ContentUnavailableView("You have no projects yet", systemImage: "tag")
                        } else {
                            Picker("Project", selection: $newTaskProject) {
                                ForEach(allProjects) { project in
                                    Text(project.title)
                                    .tag(Optional(project))
                                }
                            }
                        }
                    }
                    Button("Save") { createTask() }
                        .disabled(newTaskName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
            Section("Tasks") {
                if allTasks.isEmpty {
                    ContentUnavailableView("You have no tasks yet", systemImage: "list.bullet.clipboard.fill")
                } else {
                    ForEach(allTasks) { task in
                        Text(task.name)
                    }
                        .onDelete { indexSet in
                        indexSet.forEach { index in
                            context.delete(allTasks[index])
                        }
                        try? context.save()
                    }
                }
            }
        }
    }

    func createTask() {
        
        let task = Task(name: newTaskName, note: newTaskNote)

        if let project = newTaskProject {
            task.project = project
        }

        context.insert(object: task)
        try? context.save()

        newTaskName = ""
        newTaskNote = ""
        newTaskProject = nil
    }
}

#Preview {
    TaskListView()
}
