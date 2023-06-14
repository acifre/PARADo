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
    @Environment(\.isSearching) var isSearching

    @State var projectSearchText: String = ""
    @State var projectSortBy: ProjectSortBy = .createdAt
    @State var projectOrderBy: OrderBy = .descending

    @State var taskSearchText: String = ""
    @State var taskOrderBy: OrderBy = .ascending
    @State var taskFilterBy: TaskFilterBy = .notCompleted

    var body: some Scene {
        WindowGroup {
            TabView {
                taskList
                projectList
            }
                .preferredColorScheme(.dark)
  //              .navigationBarTitleTextColor(tabSelection == 0 ? .blue : .green)
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
        }
            .tabItem {
            Label("Projects", systemImage: "list.bullet.rectangle")
            }
    }

    var taskList: some View {
        NavigationStack {
            TaskListView(allTasks: taskListQuery)
                .searchable(text: $taskSearchText, prompt: "Search Tasks")
                .textInputAutocapitalization(.sentences)
                .navigationTitle("Tasks")
                .toolbar {
                    ToolbarItemGroup(placement: .topBarLeading) {
                        Menu {
                            Picker("Filter by", selection: $taskFilterBy) {
                                ForEach(TaskFilterBy.allCases) {
                                    Text($0.text).id($0)
                                }
                            }
                        } label: {
                            Label(taskOrderBy.text, systemImage: "ellipsis.circle")
                        }
                    }

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
        let searchIsNotEmpty = !taskSearchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty

        if taskFilterBy == .completed {
            if searchIsNotEmpty {
                predicate = #Predicate { $0.isComplete == true && $0.name.contains(taskSearchText) }
            } else {
                predicate = #Predicate { $0.isComplete == true }
            }
        } else if taskFilterBy == .notCompleted {
            if searchIsNotEmpty {
                predicate = #Predicate { $0.isComplete == false && $0.name.contains(taskSearchText) }
            } else {
                predicate = #Predicate { $0.isComplete == false }
            }
        } else if taskFilterBy == .all {
            if searchIsNotEmpty {
                predicate = #Predicate { $0.name.contains(taskSearchText) }
            } else {
                predicate = nil
            }
        } else {
            predicate = nil
        }

        return Query(filter: predicate, sort: \.name, order: sortOrder)

    }
}
