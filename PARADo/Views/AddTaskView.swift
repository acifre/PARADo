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

    @State var newTaskName = ""
    @State var newTaskNote = ""
    @State var newTaskDateDue: Date?
    @State var newTaskProject: Project?

    @State var showingDatePicker = false
    @State var showingProjectPicker = false


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
                    HStack {
                        Image(systemName: "calendar")
                        Text("Due")
                        Spacer()
                        Toggle("Due date", isOn: $showingDatePicker)
                            .toggleStyle(.switch)
                            .labelsHidden()
                    }

                    if showingDatePicker {
                        DatePicker("Date due", selection: $newTaskDateDue.toUnwrapped(defaultValue: .now), displayedComponents: .date)
                            .datePickerStyle(.compact)
                    }

                    HStack {
                        Image(systemName: "list.bullet.rectangle")
                        Text("Project")
                        Spacer()
                        Toggle("Project", isOn: $showingProjectPicker)
                            .toggleStyle(.switch)
                            .labelsHidden()
                            .disabled(allProjects.isEmpty)
                            .onChange(of: showingProjectPicker) {
                                if !showingProjectPicker {
                                    newTaskProject = nil
                                } else {
                                    newTaskProject = allProjects.first
                                }
                            }

                    }
                    if allProjects.isEmpty {
                        ContentUnavailableView("You have no projects yet", systemImage: "list.bullet.rectangle")
                    }

                    if showingProjectPicker  {
                        DisclosureGroup("Add to") {
                            if allProjects.isEmpty {
                                ContentUnavailableView("You have no projects yet", systemImage: "list.bullet.rectangle")
                            } else {
                                Picker("Project", selection: $newTaskProject) {
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
                    Button("Add") { createTask() }
                        .disabled(newTaskName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }

    private func createTask() {

        withAnimation {
            let task = Task(name: newTaskName, note: newTaskNote)

            if showingDatePicker {
                task.dateDue = newTaskDateDue
                task.hasDueDate = true
            }

            if let project = newTaskProject {
                task.project = project
                task.hasProject = true
            }

            context.insert(object: task)
            try? context.save()

            newTaskName = ""
            newTaskNote = ""
            newTaskProject = nil
            newTaskDateDue = nil

            dismiss()
        }
    }
}

//#Preview {
//    AddTaskView()
//}
