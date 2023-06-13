//
//  KeyboardGroupView.swift
//  PARADo
//
//  Created by Anthony Cifre on 6/13/23.
//

import SwiftData
import SwiftUI

struct KeyboardGroupView: View {
    @Query var allProjects: [Project]

    @Bindable var task: Task

    var body: some View {
        Group {
            Spacer()
            Button {
                withAnimation {
                    task.isImportant.toggle()
                }
            } label: {
                Image(systemName: task.isImportant ? "flag.fill" : "flag")
            }
            .tint(.yellow)
            Spacer()
            Button {
                withAnimation {
                    task.hasDueDate.toggle()
                }
            } label: {
                Image(systemName: task.hasDueDate ? "calendar.badge.minus" : "calendar.badge.plus")
            }
            .tint(.red)
            Spacer()
            Button {
                withAnimation {
                    task.hasProject.toggle()
                }
            } label: {
                Image(systemName: task.hasProject ? "list.bullet.clipboard.fill" : "list.bullet.clipboard")
            }
            .tint(.green)
            .disabled(allProjects.isEmpty)

            Spacer()
        }
    }
}

//#Preview {
//    KeyboardGroupView()
//}
