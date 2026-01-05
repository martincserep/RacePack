//
//  RacesListView.swift
//  RacePack
//
//  Created by Martin Cserép on 2026. 01. 05..
//

import SwiftUI

struct OnboardingView: View {
  @EnvironmentObject private var router: AppRouter

  var body: some View {
    List {
      Button("Onboarding") {
        router.open(.raceDetail(id: "ABC"), on: .races, requiresPremium: false, isPremium: true)
      }
    }
    .navigationTitle("Onboarding")
  }
}
