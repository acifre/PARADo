//
//  TaskListView.swift
//  PARADo
//
//  Created by Anthony Cifre on 6/11/23.
//

import SwiftData
import SwiftUI

struct TaskListView: View {
    @Environment(\.modelContext) var context
    @Query(sort: \.title) var allProjects: [Project]
    @Query(sort: \.name) var allTasks: [Task]

    @State var newTaskName = ""
    @State var newTaskNote = ""
    @State var newTaskProject: Project?



    var body: some View {
        List {
            Section {
                DisclosureGroup("Create Task") {
                    TextField("Task name", text: $newTaskName)

                    TextField("Task description", text: $newTaskNote, axis: .vertical)
                        .lineLimit(2...4)
                    if !allProjects.isEmpty {
                        DisclosureGroup("Project") {
                            Picker("Project", selection: $newTaskProject) {
                                ForEach(allProjects) { project in
                                    Text(project.title)

                                }
                            }
                        }
                    } else {
                        ContentUnavailableView("You have no projects yet", systemImage: "list.bullet.clipboard.fill")
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
        
        let task = Task(id: UUID().uuidString, name: newTaskName, note: newTaskNote)
        
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
