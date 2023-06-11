//
//  TaskCell.swift
//  PARADo
//
//  Created by Anthony Cifre on 6/11/23.
//

import SwiftUI

struct TaskCell: View { 
  var task: Task

  var body: some View {
    HStack {
      Image(systemName: task.isComplete ? "checkmark.circle.fill" : "circle")
        .resizable()
        .frame(width: 20, height: 20) // (12)
      Text(task.name)
        .strikethrough(task.isComplete)

    }
  }
}

//#Preview {
//    TaskCell()
//}
