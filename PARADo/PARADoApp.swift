//
//  PARADoApp.swift
//  PARADo
//
//  Created by Anthony Cifre on 6/10/23.
//

import SwiftData
import SwiftUI

@main
struct PARADoApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                projectList
                taskList
            }
        }
        .modelContainer(for: [
            Project.self,
            Task.self
        ])
    }
    var projectList: some View {
        NavigationStack {
            ProjectListView()
        }
        .tabItem {
            Label("Projects", systemImage: "list.bullet.rectangle")
    }
    }
    
    var taskList: some View {
        NavigationStack {
            TaskListView()
        }
        .tabItem {
            Label("Tasks", systemImage: "list.bullet")
    }
    }
}
