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

    @Query var allProjects: [Project]

    @State var task = Task()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Task name", text: $task.name)
                        .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            KeyboardGroupView(task: task)
                        }
                    }
                    TextField("Add note", text: $task.note, axis: .vertical)
                        .lineLimit(3...6)
                }

                Section {
                    HStack {
                        Image(systemName: task.isImportant ? "flag.fill" : "flag")
                            .foregroundStyle(task.isImportant ? .yellow : .secondary)
                        Text("Important")
                        Spacer()
                        Toggle("Important", isOn: $task.isImportant)
                            .toggleStyle(.switch)
                            .labelsHidden()
                    }
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundStyle(task.hasDueDate ? .red : .secondary)
                        Text("Due")
                        Spacer()
                        Toggle("Due date", isOn: $task.hasDueDate)
                            .toggleStyle(.switch)
                            .labelsHidden()
                    }

                    if task.hasDueDate {
                        DatePicker("Date due", selection: $task.dateDue.toUnwrapped(defaultValue: .now), displayedComponents: .date)
                            .datePickerStyle(.compact)
                    }

                    HStack {
                        Image(systemName: "list.bullet.rectangle")
                            .foregroundStyle(task.hasProject ? .green : .secondary)
                        Text("Project")
                        Spacer()
                        Toggle("Project", isOn: $task.hasProject)
                            .toggleStyle(.switch)
                            .labelsHidden()
                            .disabled(allProjects.isEmpty)
                            .onChange(of: task.hasProject) {
                            withAnimation {
                                if !task.hasProject {
                                    task.project = nil
                                } else {
                                    task.project = allProjects.first
                                }
                            }
                        }

                    }
                    if allProjects.isEmpty {
                        ContentUnavailableView("You have no projects yet", systemImage: "list.bullet.rectangle")
                    }

                    if task.hasProject {
                        DisclosureGroup("Add to") {
                            if allProjects.isEmpty {
                                ContentUnavailableView("You have no projects yet", systemImage: "list.bullet.rectangle")
                            } else {
                                Picker("Project", selection: $task.project) {
                                    ForEach(allProjects) { project in
                                        Text(project.displayTitle)
                                            .tag(Optional(project))
                                    }
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
                    Button("Add") {
                        withAnimation {
                            context.insert(object: task)
                            dismiss()
                        }
                    }
                        .disabled(task.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}

//#Preview {
//    AddTaskView()
//}




