//
//  ChronosApp.swift
//  Chronos
//
//  Created by Joseph Iglecias on 10/27/24.
//

import SwiftUI
import SwiftData

@main
struct ChronosApp: App {
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))

    }
    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [IndividualTask.self])
    }
}
