//
//  AddTaskView.swift
//  PARADo
//
//  Created by Anthony Cifre on 6/11/23.
//

import SwiftData
import SwiftUI

struct AddTaskView: View {

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @Query(sort: \.title) var allProjects: [Project]
    @Query(sort: \.name) var allTasks: [Task]

    @State var newTaskName = ""
    @State var newTaskNote = ""
    @State var newTaskDateDue = Date()
    @State var newTaskProject: Project?

    @State var showingDatePicker = false

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Task name", text: $newTaskName)
                        .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Button {
                                showingDatePicker.toggle()
                            } label: {
                                Image(systemName: "calendar")
                            }
                        }
                    }
                    TextField("Add note", text: $newTaskNote, axis: .vertical)
                        .lineLimit(3...6)
                }

                Section {
                    if showingDatePicker {
                        DatePicker("Date due", selection: $newTaskDateDue, displayedComponents: .date)
                            .datePickerStyle(.compact)
                    }

                    DisclosureGroup("Add to") {
                        if allProjects.isEmpty {
                            ContentUnavailableView("You have no projects yet", systemImage: "list.bullet.rectangle")
                        } else {
                            Picker("Project", selection: $newTaskProject) {
                                ForEach(allProjects) { project in
                                    Text(project.title)
                                        .tag(Optional(project))
                                }
                            }
                        }
                    }
                }
            }
                .navigationTitle("Add Task")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") { createTask() }
                        .disabled(newTaskName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }

    func createTask() {

        let task = Task(name: newTaskName, note: newTaskNote)

        if showingDatePicker {
            task.dateDue = newTaskDateDue
        }

        if let project = newTaskProject {
            task.project = project
        }

        context.insert(object: task)
        try? context.save()

        newTaskName = ""
        newTaskNote = ""
        newTaskProject = nil

        dismiss()
    }
}

//#Preview {
//    AddTaskView()
//}
