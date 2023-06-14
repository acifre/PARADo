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
    @Query var allTasks: [Task]

    @State var task = Task()

    var body: some View {
        NavigationView {
                TaskFormSectionView(task: task)
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
