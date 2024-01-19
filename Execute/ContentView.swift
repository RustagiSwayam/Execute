//
//  ContentView.swift
//  Execute
//
//  Created by Swayam Rustagi on 17/01/24.
//

import SwiftUI
import CoreData

struct TaskItem: Identifiable, Codable{
    var id = UUID()
    let taskName: String
    let taskDesc: String
    let dueData: Date
    let priority: String
}

class Tasks: ObservableObject{
    @Published var items = [TaskItem](){
        didSet{
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.setValue(encoded, forKey: "Items")
            }
        }
    }
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decodedItems = try? JSONDecoder().decode([TaskItem].self, from: savedItems){
                items = decodedItems
                return
            }
        }
        items = []
    }
}

struct ContentView: View {
    
    @ObservedObject private var tasks = Tasks()
    @State private var isShowingTask = false

    
    var body: some View {
        NavigationView{
            if tasks.items.isEmpty {
                Text("Yay!, no tasks for today!")
                    .foregroundColor(.secondary)
                    .navigationBarTitle("""
\(tasks.items.count) tasks to Execute.
""")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Add Item", systemImage: "plus") {
                                isShowingTask = true
                            }
                        }
                    }
            }else{
                List{
                    ForEach(tasks.items, id: \.id){task in
                        Taskview(taskName: task.taskName, taskDesc: task.taskDesc, dueDate: task.dueData, priority: task.priority)
                    }
                    .onDelete(perform: removeRow)
                    
                    Spacer()
                }
                .navigationBarTitle("\(tasks.items.count) tasks to Execute.")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Add Item", systemImage: "plus") {
                            isShowingTask = true
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingTask){
            addTaskSheet(tasks: tasks)
        }
    }
    func removeRow(at offSets: IndexSet) {
        tasks.items.remove(atOffsets: offSets)
    }
}

  
#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
