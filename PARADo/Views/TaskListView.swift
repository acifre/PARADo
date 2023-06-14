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
    @Query var allTasks: [Task]

    @State private var taskToEdit: Task?

    @State private var showingAddTask = false
    @State private var showingInfo = false

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        //use the locale date style
        formatter.dateStyle = .short
        //set the locale to the user's locale
        formatter.locale = Locale.current
        return formatter
    }()

    var body: some View {
        VStack(alignment: .leading) {
            List {
                if allTasks.isEmpty {

                    ContentUnavailableView("You have no tasks yet", systemImage: "list.bullet", description: Text("Add a task to get started!"))
                        .contextMenu(ContextMenu(menuItems: {
                            Button {
                                withAnimation {
                                    for task in Task.exampleTasks {
                                        context.insert(task)
                                    }
                                    try? context.save()

                                }
                            } label: {
                                Text("Add Example Tasks")
                            }
                        }))

                } else {
                    ForEach(allTasks) { task in
                        TaskCell(task: task)
                            .swipeActions {
                            Button {
                                withAnimation {
                                    context.delete(task)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                                    .symbolVariant(.fill)
                                    .tint(.red)
                            }

                            Button {
                                withAnimation {
                                    taskToEdit = task
                                }
                            } label: {
                                Label("Edit", systemImage: "pencil")
                                    .tint(.yellow)
                            }
                        }
                    }
                }
                Button(action: { showingAddTask.toggle() }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("New Task")
                    }
                }
//                    .contextMenu(ContextMenu(menuItems: {
//                    Button {
//                        withAnimation {
//                            for task in allTasks {
//                                context.delete(task)
//                            }
//                        }
//
//                    } label: {
//                        Text("Delete example tasks")
//                    }
//
//                }))
                    .sheet(isPresented: $showingAddTask) {
                    AddTaskView()
                }
                    .sheet(item: $taskToEdit, onDismiss: {
                    taskToEdit = nil
                }, content: { task in
                        TaskDetailView(showingInfo: $showingInfo, task: task)
                    })
                    .tint(.accentColor)
            }
            .contextMenu(ContextMenu(menuItems: {
                Button {
                    withAnimation {
                        for task in Task.exampleTasks {
                            context.insert(task)
                        }
                        try? context.save()

                    }
                } label: {
                    Text("Add Example Tasks")
                }
                Button {
                    withAnimation {
                        for task in allTasks {
                            context.delete(task)
                        }
                        try? context.save()

                    }
                } label: {
                    Text("Delete All Tasks")
                }
            }))
        }
            .navigationBarTitle("Tasks")

    }
}

#Preview {
    TaskListView()
}
