//
//  ProjectListView.swift
//  PARADo
//
//  Created by Anthony Cifre on 6/10/23.
//

import SwiftData
import SwiftUI

struct ProjectListView: View {
    @Environment(\.modelContext) var context
    @Query(sort: \.title) var allProjects: [Project]

    @State var newProjectTitle = ""
    @State var newProjectDescription = ""



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
                        Text(project.title)
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
//        var tags = [Tag]()
//
//        for tag in allTags {
//            if tag.isChecked {
//                tags.append(tag)
//                tag.isChecked = false
//            }
//        }
        let project = Project(id: UUID().uuidString, title: newProjectTitle, content: newProjectDescription, tasks: [])

        context.insert(object: project)
        try? context.save()

        newProjectTitle = ""
        newProjectDescription = ""
    }
}

#Preview {
    ProjectListView()
}
