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
    @Query var allProjects: [Project]

    @State var newProjectTitle = ""
    @State var newProjectDescription = ""
    @State var newProjectDateDue = Date()

    @State var showingDatePicker = false
    @State var showingAddProject = false

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
                if allProjects.isEmpty {
                    ContentUnavailableView("You have no projects yet", systemImage: "list.bullet.clipboard.fill")
                } else {
                    ForEach(allProjects) { project in
                        VStack(alignment: .leading) {
                            Text(project.displayTitle)
                                .font(.headline)
                            Text(project.displayDateCreated, style: .date)
                                .font(.caption)
                        }
                    }
                        .onDelete { indexSet in
                            withAnimation {
                                indexSet.forEach { index in
                                    context.delete(allProjects[index])
                                }
                                try? context.save()
                            }
                    }
                }

                Button(action: { showingAddProject.toggle() }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("New Project")
                    }
                }
                    .sheet(isPresented: $showingAddProject) {
                    AddProjectView()

                }
            }
        }
            .navigationBarTitle("Projects")
            .tint(.green)
    }
}

#Preview {
    ProjectListView()
}
