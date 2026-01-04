//
//  ItemCategory.swift
//  RacePack
//
//  Created by Martin Cserép on 2026. 01. 05..
//

import Foundation

enum ItemCategory: String, Codable, CaseIterable, Identifiable {
  case essentials, clothing, nutrition, electronics, tools, bike, swim, run, medical, other
  var id: String { rawValue }
}
