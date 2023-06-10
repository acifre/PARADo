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
            ContentView()
        }
        .modelContainer(for: [
            Project.self,
            Task.self
        ])
    }
}
