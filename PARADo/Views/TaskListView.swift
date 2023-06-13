//
//  TaskListView.swift
//  PARADo
//
//  Created by Anthony Cifre on 6/11/23.
//

import SwiftData
import SwiftUI

struct TaskListView: View {

    @Environment(\.modelContext) private var context
    @Query(filter: #Predicate { $0.isComplete == false },
    sort: \.dateCreated, order: .reverse) var allTasks: [Task]

    @State private var taskToEdit: Task?

    @State var showingAddTask = false
    @State var showingInfo = false

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
                    ContentUnavailableView("You have no tasks yet", systemImage: "list.bullet.clipboard.fill")
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
        }
            .navigationBarTitle("Tasks")
    }
}

#Preview {
    TaskListView()
}
