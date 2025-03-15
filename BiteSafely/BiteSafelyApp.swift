//
//  BiteSafelyApp.swift
//  BiteSafely
//
//  Created by Niral sara on 3/15/25.
//

import SwiftUI

@main
struct BiteSafelyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
