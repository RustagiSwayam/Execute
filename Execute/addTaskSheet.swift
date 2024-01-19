import SwiftUI

struct addTaskSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var taskName = ""
    @State private var taskDesc = ""
    @State private var priority = "Low"
    @State private var dueDate = Date()
    @State private var isShowingAlert = false

    var tasks: Tasks

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("eg. Coding", text: $taskName)
                    TextField("eg. complete c++", text: $taskDesc)
                    Picker("Priority", selection: $priority) {
                        Text("Low").tag("Low")
                        Text("Medium").tag("Medium")
                        Text("High").tag("High")
                    }
                    DatePicker("Due Date", selection: $dueDate, in: Date()..., displayedComponents: .date)
                }

                Section {
                    Button(action: {
                        if !taskName.isEmpty && !taskDesc.isEmpty {
                            let item = TaskItem(taskName: taskName, taskDesc: taskDesc, dueData: dueDate, priority: priority)
                            tasks.items.append(item)
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            isShowingAlert = true
                        }
                    }) {
                        Text("Add Task")
                    }
                }
            }
            .navigationTitle("Add Task")
            .alert(isPresented: $isShowingAlert) {
                Alert(
                    title: Text("No task added"),
                    message: Text("Task Name and Task Description cannot be empty."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

struct addTaskSheet_Previews: PreviewProvider {
    static var previews: some View {
        addTaskSheet(tasks: Tasks())
    }
}
