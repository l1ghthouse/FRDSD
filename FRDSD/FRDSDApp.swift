//
//  FRDSDApp.swift
//  FRDSD
//
//  Created by Peter Cammeraat on 01/09/2020.
//

import SwiftUI

@main
struct FRDSDApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
