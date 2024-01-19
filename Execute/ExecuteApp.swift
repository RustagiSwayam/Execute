//
//  ExecuteApp.swift
//  Execute
//
//  Created by Swayam Rustagi on 17/01/24.
//

import SwiftUI

@main
struct ExecuteApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
