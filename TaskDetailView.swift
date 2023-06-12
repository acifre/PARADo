//
//  TaskDetailView.swift
//  PARADo
//
//  Created by Anthony Cifre on 6/12/23.
//

import SwiftData
import SwiftUI

struct TaskDetailView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss

    @Query var allProjects: [Project]

    @State private var showingDatePicker = false
    @State private var showingProjectPicker = false

    @State private var editedDateDue = Date()

    @Binding var showingInfo: Bool

    @Bindable var task: Task

    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        //use the locale date style
        formatter.dateStyle = .short
        //set the locale to the user's locale
        formatter.locale = Locale.current
        return formatter
    }()


    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Task name", text: $task.name)
                    TextField("Notes", text: $task.note, axis: .vertical)
                        .lineLimit(3...6)
                }

                Section {
                    HStack {
                        Image(systemName: "calendar")
                        Text("Due")
                        Spacer()
                        Toggle("Due", isOn: $task.hasDueDate.animation())
                            .toggleStyle(.switch)
                            .labelsHidden()
                            .onChange(of: task.hasDueDate) {
                            if !task.hasDueDate {
                                task.dateDue = nil
                            }
                        }
                    }
                    if task.hasDueDate {
                        Text(task.dateDue ?? .now, formatter: dateFormatter)
                        DatePicker("Date due", selection: $task.dateDue.toUnwrapped(defaultValue: .now), displayedComponents: .date)
                            .datePickerStyle(.graphical)
                    }

                }

                Section {
                    HStack {
                        Image(systemName: "list.bullet.rectangle")
                        Text("Project")
                        Spacer()
                        Toggle("Project", isOn: $task.hasProject)
                            .toggleStyle(.switch)
                            .labelsHidden()
                            .disabled(allProjects.isEmpty)
                            .onChange(of: task.hasProject) {

                            if !task.hasProject {
                                task.project = nil
                            } else {
                                task.project = allProjects.first
                            }
                        }

                    }

                    if allProjects.isEmpty {
                        ContentUnavailableView("You have no projects yet", systemImage: "list.bullet.rectangle")
                    }

                    if task.hasProject {
                        DisclosureGroup("Choose project") {
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

                    Text(task.project?.displayTitle ?? "No project")

                }
            }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Details")
                .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        try? context.save()
                        dismiss()
                        showingInfo = false
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                        showingInfo = false
                    }
                }

            }
        }
    }
}

//#Preview {
//    TaskDetailView()
//}
