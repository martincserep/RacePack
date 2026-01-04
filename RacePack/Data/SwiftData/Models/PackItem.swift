//
//  PackItem.swift
//  RacePack
//
//  Created by Martin Cserép on 2026. 01. 05..
//

import Foundation
import SwiftData

@Model
final class PackItem {
  @Attribute(.unique) var id: UUID

  var name: String
  var categoryRaw: String
  var quantity: Int
  var isPacked: Bool
  var notes: String?
  var sortOrder: Int

  // back-reference
  var pack: Pack?

  init(
    id: UUID = UUID(),
    name: String,
    category: ItemCategory,
    quantity: Int = 1,
    isPacked: Bool = false,
    notes: String? = nil,
    sortOrder: Int = 0,
    pack: Pack? = nil
  ) {
    self.id = id
    self.name = name
    self.categoryRaw = category.rawValue
    self.quantity = quantity
    self.isPacked = isPacked
    self.notes = notes
    self.sortOrder = sortOrder
    self.pack = pack
  }

  var category: ItemCategory {
    get { ItemCategory(rawValue: categoryRaw) ?? .other }
    set { categoryRaw = newValue.rawValue }
  }
}
