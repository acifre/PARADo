//
//  ProjectListView.swift
//  PARADo
//
//  Created by Anthony Cifre on 6/10/23.
//

import SwiftData
import SwiftUI

struct ProjectListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \.title) var allProjects: [Project]

    @State var newProjectTitle = ""
    @State var newProjectDescription = ""

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        //use the locale date style
        formatter.dateStyle = .short
        //set the locale to the user's locale
        formatter.locale = Locale.current
        return formatter
    }()

    var body: some View {
        List {
            Section {
                DisclosureGroup("Create Project") {
                    TextField("Project title", text: $newProjectTitle)

                    TextField("Project description", text: $newProjectDescription, axis: .vertical)
                        .lineLimit(2...4)

                    Button("Save") { createProject() }
                        .disabled(newProjectTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
            Section("Projects") {
                if allProjects.isEmpty {
                    ContentUnavailableView("You have no projects yet", systemImage: "list.bullet.clipboard.fill")
                } else {
                    ForEach(allProjects) { project in
                        NavigationLink {

                            VStack {
                                Text(project.title)
                                Text(project.content)
                                Text("\(project.tasks.count)")

                                VStack {
                                    ForEach(project.tasks) { task in
                                        Text(task.name)
                                    }
                                }
                            }
                        } label: {
                            VStack(alignment: .leading) {
                                Text(project.title)
                                Text(project.dateCreated, formatter: dateFormatter)
                                    .font(.caption)
                            }
                        }
                    }
                        .onDelete { indexSet in
                        indexSet.forEach { index in
                            context.delete(allProjects[index])
                        }

                        try? context.save()

                    }
                }
            }
        }
    }

    func createProject() {

        let project = Project(title: newProjectTitle, content: newProjectDescription)

        context.insert(object: project)
        try? context.save()

        newProjectTitle = ""
        newProjectDescription = ""
    }
}

#Preview {
    ProjectListView()
}
