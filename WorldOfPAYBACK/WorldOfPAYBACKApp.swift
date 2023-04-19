//
//  WorldOfPAYBACKApp.swift
//  WorldOfPAYBACK
//
//  Created by Ramkrishna Baddi on 15/04/2023.
//

import SwiftUI

@main
struct WorldOfPAYBACKApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
