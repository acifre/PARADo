//
//  ContentView.swift
//  PARADo
//
//  Created by Anthony Cifre on 6/10/23.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query var allProjects: [Project]

    var examples = ["Inbox", "Current", "Area", "Archive"]

    var body: some View {
        NavigationView {
            List {
//                Spacer()
                Section("Tasks") {

                }
                Section("Projects") {
                    ForEach(examples, id: \.self) { example in
                        DisclosureGroup(example) {
                            ProjectSubView(projects: allProjects)

                        }

    //                    if example != examples.last {
    //                        Divider()
    //                    }
                    }
                }

            }
            .padding()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}

struct ProjectSubView: View {

    var projects: [Project]

    var body: some View {
        ForEach(projects, id: \.self) { project in
            HStack {
                Text(project.displayTitle)
                    .padding(.leading, 5)
                Spacer()
            }
            .padding(2)
        }
    }
}
