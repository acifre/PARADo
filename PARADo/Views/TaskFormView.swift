//
//  TaskFormView.swift
//  PARADo
//
//  Created by Anthony Cifre on 6/13/23.
//

import SwiftData
import SwiftUI

struct TaskFormSectionView: View {
    @Query var allProjects: [Project]
    @Bindable var task: Task

    var body: some View {
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
    }
}


//#Preview {
//    TaskFormSectionView()
//}
