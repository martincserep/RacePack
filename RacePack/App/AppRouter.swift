//
//  AppRouter.swift
//  RacePack
//
//  Created by Martin Cserép on 2026. 01. 05..
//

import SwiftUI
internal import Combine

@MainActor
final class AppRouter: ObservableObject {
  @Published var selectedTab: AppTab = .races

  @Published var racesPath = NavigationPath()
  @Published var packsPath = NavigationPath()
  @Published var settingsPath = NavigationPath()

  @Published var sheet: SheetRoute?

  private var deferred: (tab: AppTab, route: Route)?

  func push(_ route: Route, on tab: AppTab) {
    switch tab {
    case .races: racesPath.append(route)
    case .packs: packsPath.append(route)
    case .settings: settingsPath.append(route)
    }
  }

  func pop(on tab: AppTab) {
    switch tab {
    case .races: if !racesPath.isEmpty { racesPath.removeLast() }
    case .packs: if !packsPath.isEmpty { packsPath.removeLast() }
    case .settings: if !settingsPath.isEmpty { settingsPath.removeLast() }
    }
  }

  func reset(tab: AppTab) {
    switch tab {
    case .races: racesPath = NavigationPath()
    case .packs: packsPath = NavigationPath()
    case .settings: settingsPath = NavigationPath()
    }
  }

  /// Notification / deep link entry point
  func open(
    _ route: Route,
    on tab: AppTab,
    requiresPremium: Bool,
    isPremium: Bool
  ) {
    selectedTab = tab

    if requiresPremium && !isPremium {
      deferred = (tab, route)
      sheet = .paywall
      return
    }

    push(route, on: tab)
  }

  func presentPaywall() { sheet = .paywall }
  func presentOnboarding() { sheet = .onboarding }

  func completePaywall(isPremium: Bool) {
    sheet = nil
    guard isPremium, let deferred else { return }
    self.deferred = nil
    selectedTab = deferred.tab
    push(deferred.route, on: deferred.tab)
  }
}
