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

    @State var projectSearchText: String = ""
    @State var projectSortBy: ProjectSortBy = .createdAt
    @State var projectOrderBy: OrderBy = .descending

    @State var taskSearchText: String = ""
    @State var taskOrderBy: OrderBy = .ascending

    var body: some Scene {
        WindowGroup {
            TabView {
                taskList
                projectList
            }
                .preferredColorScheme(.dark)
        }
            .modelContainer(for: [
            Project.self,
            Task.self
            ])

    }
    var projectList: some View {
        NavigationStack {
            ProjectListView(allProjects: projectListQuery)
                .searchable(text: $projectSearchText, prompt: "Search Projects")
                .textInputAutocapitalization(.never)
                .navigationTitle("Projects")
//                .toolbar {
//                ToolbarItem(placement: .topBarTrailing) {
//                    Menu {
//                        Picker("Order by", selection: $projectOrderBy) {
//                            ForEach(OrderBy.allCases) {
//                                Text($0.text).id($0)
//                            }
//                        }
//                    } label: {
//                        Label(projectOrderBy.text, systemImage: "arrow.up.arrow.down")
//                    }
//                }
//            }
        }
            .tabItem {
            Label("Projects", systemImage: "list.bullet.rectangle")
        }
    }

    var taskList: some View {
        NavigationStack {
            TaskListView(allTasks: taskListQuery)
                .searchable(text: $taskSearchText, prompt: "Search Tasks")
                .textInputAutocapitalization(.never)
                .navigationTitle("Tasks")
                .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Order by", selection: $taskOrderBy) {
                            ForEach(OrderBy.allCases) {
                                Text($0.text).id($0)
                            }
                        }
                    } label: {
                        Label(taskOrderBy.text, systemImage: "arrow.up.arrow.down")
                    }
                }
            }
        }
            .tabItem {
            Label("Tasks", systemImage: "list.bullet")
        }
    }

    var projectListQuery: Query<Project, [Project]> {
        var predicate: Predicate<Project>?

        if !projectSearchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            predicate = .init(#Predicate { $0.content.contains(projectSearchText) })
        }

        return Query(filter: predicate)
    }



    var taskListQuery: Query<Task, [Task]> {
        let sortOrder: SortOrder = taskOrderBy == .ascending ? .forward : .reverse
        var predicate: Predicate<Task>?

        if !taskSearchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            predicate = .init(#Predicate { $0.name.contains(taskSearchText) })
        }

        return Query(filter: predicate, sort: \.name, order: sortOrder)
    }
}
