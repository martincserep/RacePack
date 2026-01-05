//
//  DeepLinkManager.swift
//  RacePack
//
//  Created by Martin Cserép on 2026. 01. 05..
//

import Foundation

enum DeepLink {
  case route(tab: AppTab, route: Route, requiresPremium: Bool)
}

struct DeepLinkManager {
  func parse(url: URL) -> DeepLink? {
    guard url.scheme == "racepack" else { return nil }

    // racepack://race/<id>
    let host = url.host ?? ""
    let parts = url.pathComponents.filter { $0 != "/" }

    if host == "race", let id = parts.first {
      return .route(tab: .races, route: .raceDetail(id: id), requiresPremium: false)
    }

    return nil
  }
}
