//
//  SheetRoute.swift
//  RacePack
//
//  Created by Martin Cserép on 2026. 01. 05..
//

import Foundation

enum SheetRoute: Identifiable {
  case paywall
  case onboarding

  var id: String { String(describing: self) }
}
