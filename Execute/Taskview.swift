//
//  Taskview.swift
//  Execute
//
//  Created by Swayam Rustagi on 17/01/24.
//

import SwiftUI

struct Taskview: View {
    var taskName: String
    var taskDesc: String
    var dueDate: Date
    var priority: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Text(taskName)
                    .bold()
                Text(taskDesc)
                Text("Complete by: \(formattedDueDate)")
            }
            Spacer()
            
            priorityBadge
            
            Spacer()
        }
        .foregroundColor(.black)
        .padding()
        .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                    )
        .padding([.top, .horizontal], 10)
    }
    
    private var formattedDueDate: String {
          let dateFormatter = DateFormatter()
          dateFormatter.dateStyle = .medium
          return dateFormatter.string(from: dueDate)
      }
    
    private var priorityBadge: some View {
            switch priority {
            case "High":
                return Text(priority)
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.red)
                    .clipShape(Capsule())
            case "Medium":
                return Text(priority)
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.green)
                    .clipShape(Capsule())
            case "Low":
                return Text(priority)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.yellow)
                    .clipShape(Capsule())
            default:
                return Text(priority)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.gray)
                    .clipShape(Capsule())
            }
        }
}

struct Taskview_Previews: PreviewProvider {
    static var previews: some View {
        Taskview(
            taskName: "Taskname",
            taskDesc: "This is the task",
            dueDate: Date(),
            priority: "Low"
        )
    }
}
