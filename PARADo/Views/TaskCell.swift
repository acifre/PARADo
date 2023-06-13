//
//  TaskCell.swift
//  PARADo
//
//  Created by Anthony Cifre on 6/11/23.
//

import SwiftUI

struct TaskCell: View {
    @Environment(\.modelContext) private var context

    @State var showingInfo = false
    @State var showingDetailView = false

    @Bindable var task: Task

    var body: some View {
        HStack {
            Button {
                withAnimation {
                    task.isComplete.toggle()
                    try? context.save()
                }
            } label: {
                Image(systemName: task.isComplete ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
                .buttonStyle(.plain)

            VStack(alignment: .leading) {
                Text(task.name)
                    .strikethrough(task.isComplete)
                if (task.hasDueDate) {
                    Text(task.dateDue ?? .now, style: .date)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .strikethrough(task.isComplete)
                }
                if (task.project == nil) {

                } else {
                    Text("Project: \(task.project?.displayTitle ?? "No project")")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .strikethrough(task.isComplete)
                }

            }
            Spacer()
            if showingInfo {
                Image(systemName: "info.circle")
                    .foregroundColor(.accentColor)
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                    withAnimation {
                        showingDetailView.toggle()
                    }
                }
                    .transition(.opacity)
                    .popover(isPresented: $showingDetailView) {
                    TaskDetailView(showingInfo: $showingInfo, task: task)
                }


            } else {
                Spacer()
                    .transition(.opacity)
            }

        }
            .onLongPressGesture {
            withAnimation {
                showingInfo.toggle()
            }

        }
    }
}

//#Preview {
//    TaskCell(task: Task(name: "Example", note: "Example"))
//}
