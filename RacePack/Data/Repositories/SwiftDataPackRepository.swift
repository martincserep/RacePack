//
//  SwiftDataPackRepository.swift
//  RacePack
//
//  Created by Martin Cserép on 2026. 01. 05..
//

import Foundation
import SwiftData

@MainActor
final class SwiftDataPackRepository: PackRepository {
  private let context: ModelContext

  init(context: ModelContext) {
    self.context = context
  }

  func fetchAllPacks(includeTemplates: Bool = false) throws -> [Pack] {
    let predicate: Predicate<Pack>? = includeTemplates ? nil : #Predicate { $0.isTemplate == false }
    let desc = FetchDescriptor<Pack>(
      predicate: predicate,
      sortBy: [SortDescriptor(\.updatedAt, order: .reverse)]
    )
    return try context.fetch(desc)
  }

  func fetchPack(id: UUID) throws -> Pack? {
    let desc = FetchDescriptor<Pack>(predicate: #Predicate { $0.id == id })
    return try context.fetch(desc).first
  }

  func createPack(title: String, isTemplate: Bool = false, race: Race? = nil) throws -> Pack {
    let pack = Pack(title: title, isTemplate: isTemplate, race: race)
    context.insert(pack)
    try context.save()
    return pack
  }

  func renamePack(_ pack: Pack, title: String) throws {
    pack.title = title
    pack.touch()
    try context.save()
  }

  func deletePack(_ pack: Pack) throws {
    context.delete(pack)
    try context.save()
  }

  func addItem(to pack: Pack, name: String, category: ItemCategory, quantity: Int = 1) throws -> PackItem {
    let nextSort = (pack.items.map(\.sortOrder).max() ?? -1) + 1
    let item = PackItem(name: name, category: category, quantity: max(1, quantity), sortOrder: nextSort, pack: pack)
    pack.items.append(item)
    pack.touch()
    context.insert(item)
    try context.save()
    return item
  }

  func togglePacked(_ item: PackItem) throws {
    item.isPacked.toggle()
    item.pack?.touch()
    try context.save()
  }

  func deleteItem(_ item: PackItem) throws {
    item.pack?.touch()
    context.delete(item)
    try context.save()
  }
}
