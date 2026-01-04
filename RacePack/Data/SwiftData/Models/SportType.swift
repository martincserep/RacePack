//
//  SportType.swift
//  RacePack
//
//  Created by Martin Cserép on 2026. 01. 05..
//

import Foundation

enum SportType: String, Codable, CaseIterable, Identifiable {
  case running, cycling, swimming, triathlon, sailing, strength, other
  var id: String { rawValue }
}
