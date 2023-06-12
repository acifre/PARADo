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
    @Query(sort: \.name, order: .reverse) var allTasks: [Task]

    @State var newTaskName = ""
    @State var newTaskNote = ""
    @State var newTaskDateDue = Date()
    @State var newTaskProject: Project?

    @State var showingDatePicker = false
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
//                            .onTapGesture {
//                                withAnimation {
////                                    task.isComplete.toggle()
////                                    try? context.save()
//                                    showingInfo.toggle()
//                                
//                                }
//                        }
                    }
                        .onDelete { indexSet in
                            withAnimation {
                                indexSet.forEach { index in
                                    context.delete(allTasks[index])
                                }
                                try? context.save()
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
                    .accentColor(Color(UIColor.systemBlue))
            }
        }
            .navigationBarTitle("Tasks")
    }
}

#Preview {
    TaskListView()
}
