//
//  PackRepository.swift
//  RacePack
//
//  Created by Martin Cserép on 2026. 01. 05..
//

import Foundation
import SwiftData

protocol PackRepository {
  func fetchAllPacks(includeTemplates: Bool) throws -> [Pack]
  func fetchPack(id: UUID) throws -> Pack?
  func createPack(title: String, isTemplate: Bool, race: Race?) throws -> Pack
  func renamePack(_ pack: Pack, title: String) throws
  func deletePack(_ pack: Pack) throws

  func addItem(to pack: Pack, name: String, category: ItemCategory, quantity: Int) throws -> PackItem
  func togglePacked(_ item: PackItem) throws
  func deleteItem(_ item: PackItem) throws
}
