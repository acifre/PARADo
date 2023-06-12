//
//  AddProjectView.swift
//  PARADo
//
//  Created by Anthony Cifre on 6/11/23.
//

import SwiftData
import SwiftUI

struct AddProjectView: View {

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State var newProjectTitle = ""
    @State var newProjectDescription = ""
    @State var newProjectDateDue = Date()

    @State var showingDatePicker = false

    @State var newProjectCategory = "Inbox"

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Project title", text: $newProjectTitle)
                        .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Button {
                                withAnimation {
                                    showingDatePicker.toggle()
                                }
                            } label: {
                                Image(systemName: "calendar")
                            }
                        }
                    }

                    TextField("Project description", text: $newProjectDescription, axis: .vertical)
                        .lineLimit(3...6)

                }

                Section {

                    Picker("Category", selection: $newProjectCategory) {
                        ForEach(ProjectCategory.allCases, id: \.text) { category in
                            Text(category.text)
                                .tag(category)

                        }
                    }

                    if showingDatePicker {
                        DatePicker("Date due", selection: $newProjectDateDue, displayedComponents: .date)
                            .datePickerStyle(.compact)
                    }
                }
            }
                .navigationTitle("Add Project")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") { createProject() }
                    .disabled(newProjectTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }

    private func createProject() {

        withAnimation {
            let project = Project(title: newProjectTitle, content: newProjectDescription)
            project.category = newProjectCategory

            if showingDatePicker {
                project.dateDue = newProjectDateDue
            }

            context.insert(object: project)
            try? context.save()

            newProjectTitle = ""
            newProjectDescription = ""
            newProjectCategory = "Inbox"

            dismiss()
        }
    }
}

#Preview {
    AddProjectView()
}
