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
                ToolbarItemGroup(placement: .confirmationAction) {
                    Menu {
                        Button {
                            for task in Task.exampleTasks {
                                context.insert(object: task)
                            }
                        } label: {
                            Text("Add example tasks")
                        }
                        Button {
                            for task in allTasks {
                                context.delete(object: task)
                            }
                        
                        } label: {
                            Text("Delete example tasks")
                        }

                    } label: {
                        Label("Example menu", systemImage: "text.badge.plus")
                    }

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
