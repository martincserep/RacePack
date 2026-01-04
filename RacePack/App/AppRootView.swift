//
//  AppRootView.swift
//  RacePack
//
//  Created by Martin Cserép on 2026. 01. 05..
//

import SwiftUI

struct AppRootView: View {
  @StateObject private var router = AppRouter()

  // Ide majd a saját entitlement state-ed jön (RevenueCat / StoreKit / saját).
  @State private var isPremium = false

  private let deepLinkManager = DeepLinkManager()

  var body: some View {
    TabView(selection: $router.selectedTab) {

      NavigationStack(path: $router.racesPath) {
         RacesListView()
          .navigationDestination(for: Route.self) { route in
            switch route {
            //case .raceDetail(let id): RaceDetailView(raceId: id)
            //case .raceEdit(let id): RaceEditorView(raceId: id)
            default: EmptyView()
            }
          }
      }
      .tabItem { Label("Races", systemImage: "flag.checkered") }
      .tag(AppTab.races)

      NavigationStack(path: $router.packsPath) {
        PacksListView()
          .navigationDestination(for: Route.self) { route in
            switch route {
            //case .packDetail(let id): PackDetailView(packId: id)
            //case .packEdit(let id): PackEditorView(packId: id)
            //case .templatePicker: TemplatePickerView()
            default: EmptyView()
            }
          }
      }
      .tabItem { Label("Packs", systemImage: "bag") }
      .tag(AppTab.packs)

      NavigationStack(path: $router.settingsPath) {
        SettingsView()
      }
      .tabItem { Label("Settings", systemImage: "gearshape") }
      .tag(AppTab.settings)
    }
    .environmentObject(router)
    .onOpenURL { url in
      guard let deeplink = deepLinkManager.parse(url: url) else { return }
      switch deeplink {
      case .route(let tab, let route, let requiresPremium):
        router.open(route, on: tab, requiresPremium: requiresPremium, isPremium: isPremium)
      }
    }
//    .onReceive(NotificationCenter.default.publisher(for: AppDelegate.openRaceFromNotification)) { note in
//      guard let raceId = note.object as? String else { return }
//      router.open(.raceDetail(id: raceId), on: .races, requiresPremium: false, isPremium: isPremium)
//    }
//    .sheet(item: $router.sheet) { sheet in
//      switch sheet {
//      //case .paywall:
//      //  PaywallView(
//      //    onPurchased: {
//            // itt frissítsd isPremium-et (entitlement alapján)
//      //      isPremium = true
//      //      router.completePaywall(isPremium: isPremium)
//      //    },
//      //    onClose: { router.sheet = nil }
//      //  )
//      case .onboarding:
//        OnboardingView(
//          //onFinish: { router.sheet = nil }
//        )
//      }
//    }
  }
}
