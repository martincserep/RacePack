//
//  Race.swift
//  RacePack
//
//  Created by Martin Cserép on 2026. 01. 05..
//

import Foundation
import SwiftData

@Model
final class Race {
  @Attribute(.unique) var id: UUID
  var name: String
  var date: Date
  var location: String?
  var sportTypeRaw: String

  // inverse kapcsolat (opcionális, de hasznos)
  @Relationship(deleteRule: .nullify, inverse: \Pack.race)
  var packs: [Pack] = []

  init(
    id: UUID = UUID(),
    name: String,
    date: Date,
    location: String? = nil,
    sportType: SportType
  ) {
    self.id = id
    self.name = name
    self.date = date
    self.location = location
    self.sportTypeRaw = sportType.rawValue
  }

  var sportType: SportType {
    get { SportType(rawValue: sportTypeRaw) ?? .other }
    set { sportTypeRaw = newValue.rawValue }
  }
}
