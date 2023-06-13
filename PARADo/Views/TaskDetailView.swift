//
//  TaskDetailView.swift
//  PARADo
//
//  Created by Anthony Cifre on 6/12/23.
//

import SwiftData
import SwiftUI

struct TaskDetailView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss

    @Query var allProjects: [Project]

    @Binding var showingInfo: Bool
    @Bindable var task: Task

    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        //use the locale date style
        formatter.dateStyle = .short
        //set the locale to the user's locale
        formatter.locale = Locale.current
        return formatter
    }()


    var body: some View {
        NavigationView {
            TaskFormSectionView(task: task)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Details")
                .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        withAnimation {
                            try? context.save()
                            dismiss()
                            showingInfo = false
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .cancel) {
                        withAnimation {
                            dismiss()
                            showingInfo = false
                        }
                    }
                }

            }
        }
    }
}

//#Preview {
//    TaskDetailView()
//}
