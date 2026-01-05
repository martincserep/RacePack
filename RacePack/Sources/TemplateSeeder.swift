//
//  TemplateSeeder.swift
//  RacePack
//
//  Created by Martin Cserép on 2026. 01. 05..
//

import Foundation
import SwiftData

@MainActor
final class TemplateSeeder {
    private let loader: TemplateLoading

    // Designated init – injektálható teszthez
    init(loader: TemplateLoading) {
      self.loader = loader
    }

    // Default init – itt már MainActor kontextusban vagyunk
    convenience init() {
      self.init(loader: BundleTemplateLoader())
    }

  /// Simple gating: ha már van bármilyen template pack, nem seedelünk újra.
  func seedIfNeeded(context: ModelContext) throws {
    let existing = try context.fetch(
      FetchDescriptor<Pack>(predicate: #Predicate { $0.isTemplate == true })
    )
    guard existing.isEmpty else { return }

    let templates = try loader.loadTemplates()
    guard let first = templates.first else {
      // Elvileg ide nem jutunk, mert loader dobna hibát
      return
    }

    // Minimum AC: legalább 1 template betöltése.
    // (Nyugodtan iterálhatsz templates-en és mindet betolhatod.)
    try upsert(template: first, context: context)

    try context.save()
  }

  private func upsert(template: PackTemplateDTO, context: ModelContext) throws {
    // Itt egyszerűen insertelünk. Később: unique key alapján upsertelhetsz.
    let pack = Pack(title: template.title, isTemplate: true, race: nil)

    // ItemCategory & SportType mapping: ha nem ismert, menjen .other
    for (idx, item) in template.items.enumerated() {
      let cat = ItemCategory(rawValue: item.category) ?? .other
      let packItem = PackItem(
        name: item.name,
        category: cat,
        quantity: item.quantity,
        isPacked: false,
        sortOrder: idx,
        pack: pack
      )
      pack.items.append(packItem)
      context.insert(packItem)
    }

    pack.touch()
    context.insert(pack)
  }
}
