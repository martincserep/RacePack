//
//  RacePackApp.swift
//  RacePack
//
//  Created by Martin Cserép on 2026. 01. 04..
//

import SwiftUI
import SwiftData

@main
struct RacePackApp: App {
    @State private var container: ModelContainer = {
      let schema = Schema([Race.self, Pack.self, PackItem.self])
      let config = ModelConfiguration(schema: schema)
      return try! ModelContainer(for: schema, configurations: [config])
    }()
    
    var body: some Scene {
        WindowGroup {
          AppRootView()
            
        }
        .modelContainer(container)
    }
}
