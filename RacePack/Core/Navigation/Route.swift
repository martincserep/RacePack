//
//  Route.swift
//  RacePack
//
//  Created by Martin Cserép on 2026. 01. 05..
//

import Foundation

enum Route: Hashable {
  case raceDetail(id: String)
  case raceEdit(id: String)

  case packDetail(id: String)
  case packEdit(id: String)

  case templatePicker
}
