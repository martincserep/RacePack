//
//  SwiftDataStack.swift
//  RacePack
//
//  Created by Martin Cserép on 2026. 01. 05..
//

import Foundation
import SwiftData

@MainActor
final class SwiftDataStack {
  static let shared = SwiftDataStack()

  let container: ModelContainer

  private init() {
    let schema = Schema([
      Race.self,
      Pack.self,
      PackItem.self
    ])

    let config = ModelConfiguration(schema: schema)

    do {
      container = try ModelContainer(for: schema, configurations: [config])
    } catch {
      fatalError("Failed to create ModelContainer: \(error)")
    }
  }

  static func inMemory() -> SwiftDataStack {
    let schema = Schema([Race.self, Pack.self, PackItem.self])
    let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    do {
      let c = try ModelContainer(for: schema, configurations: [config])
      return SwiftDataStack(container: c)
    } catch {
      fatalError("Failed to create in-memory container: \(error)")
    }
  }

  // Private init variant for inMemory
  private init(container: ModelContainer) {
    self.container = container
  }
}
