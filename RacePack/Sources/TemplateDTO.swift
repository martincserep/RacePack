//
//  TemplateDTO.swift
//  RacePack
//
//  Created by Martin Cserép on 2026. 01. 05..
//

import Foundation

struct PackTemplateDTO: Codable {
  let id: String
  let title: String
  let sportType: String
  let items: [PackTemplateItemDTO]
}

struct PackTemplateItemDTO: Codable {
  let name: String
  let category: String
  let quantity: Int
}

enum TemplateValidationError: Error, CustomStringConvertible {
  case emptyTitle(templateId: String)
  case noItems(templateId: String)
  case invalidQuantity(templateId: String, itemName: String)
  case emptyItemName(templateId: String)

  var description: String {
    switch self {
    case let .emptyTitle(id): return "Template '\(id)' has empty title."
    case let .noItems(id): return "Template '\(id)' has no items."
    case let .invalidQuantity(id, itemName): return "Template '\(id)' item '\(itemName)' has invalid quantity."
    case let .emptyItemName(id): return "Template '\(id)' has an item with empty name."
    }
  }
}

extension PackTemplateDTO {
  func validate() throws {
    if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
      throw TemplateValidationError.emptyTitle(templateId: id)
    }
    if items.isEmpty {
      throw TemplateValidationError.noItems(templateId: id)
    }
    for item in items {
      if item.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
        throw TemplateValidationError.emptyItemName(templateId: id)
      }
      if item.quantity <= 0 {
        throw TemplateValidationError.invalidQuantity(templateId: id, itemName: item.name)
      }
    }
  }
}
