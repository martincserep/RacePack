//
//  Pack.swift
//  RacePack
//
//  Created by Martin Cserép on 2026. 01. 05..
//

import Foundation
import SwiftData

@Model
final class Pack {
  @Attribute(.unique) var id: UUID
  var title: String
  var createdAt: Date
  var updatedAt: Date
  var isTemplate: Bool

  // Kapcsolat a versenyhez
  var race: Race?

  // Kapcsolat az itemekhez
  @Relationship(deleteRule: .cascade, inverse: \PackItem.pack)
  var items: [PackItem] = []

  init(
    id: UUID = UUID(),
    title: String,
    isTemplate: Bool = false,
    race: Race? = nil,
    createdAt: Date = .now,
    updatedAt: Date = .now
  ) {
    self.id = id
    self.title = title
    self.isTemplate = isTemplate
    self.race = race
    self.createdAt = createdAt
    self.updatedAt = updatedAt
  }

  func touch() { updatedAt = .now }
}
