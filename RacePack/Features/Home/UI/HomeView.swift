//
//  HomeView.swift
//  RacePack
//
//  Created by Martin Cserép on 2026. 01. 05..
//

import SwiftUI

struct HomeView: View {
    // Cseréld le a saját modelledre / SwiftData @Query-ra
    let activeRace: RaceSummary? = RaceSummary(
        title: "Nagyatád Ironman",
        dateText: "Aug 9, 2026",
        locationText: "Nagyatád, HU"
    )

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {

                    // Active race card
                    if let race = activeRace {
                        ActiveRaceCard(race: race) {
                            // TODO: navigate to race / timeline
                        }
                        .padding(.top, 8)
                    } else {
                        EmptyActiveRaceCard {
                            // TODO: open new race flow
                        }
                        .padding(.top, 8)
                    }

                    // Primary CTA
                    Button {
                        // TODO: open new race flow
                    } label: {
                        Label("actions.newRace", systemImage: "plus.circle.fill")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                    }
                    .buttonStyle(.borderedProminent)
                    .accessibilityLabel("actions.newRace")
                    .accessibilityHint("Create a new race and generate a packing plan.")

                    // Quick actions
                    VStack(alignment: .leading, spacing: 10) {
                        Text("actions.quickActions")
                            .font(.headline)
                            .padding(.horizontal, 2)
                            .accessibilityAddTraits(.isHeader)

                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 12),
                            GridItem(.flexible(), spacing: 12),
                            GridItem(.flexible(), spacing: 12)
                        ], spacing: 12) {

                            QuickActionTile(
                                title: "actionsTimelineTitle",
                                systemImage: "clock",
                                subtitle: "actionsTimelineSubtitle"
                            ) {
                                // TODO: open timeline
                            }

                            QuickActionTile(
                                title: "Packing",
                                systemImage: "bag",
                                subtitle: "Checklist"
                            ) {
                                // TODO: open packing
                            }

                            QuickActionTile(
                                title: "Race Day",
                                systemImage: "flag.checkered",
                                subtitle: "Morning flow"
                            ) {
                                // TODO: open race day
                            }
                        }
                    }
                    .padding(.top, 6)

                    Spacer(minLength: 8)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
            }
            .navigationTitle("app.title")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // TODO: open new race flow
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("actions.newRace")
                }
            }
        }
    }
}

// MARK: - Components

struct ActiveRaceCard: View {
    let race: RaceSummary
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: "bolt.heart.fill")
                        .font(.title3)
                        .accessibilityHidden(true)

                    VStack(alignment: .leading, spacing: 6) {
                        Text("home.activeRace.title")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                        Text(race.title)
                            .font(.title2.weight(.semibold))
                            .foregroundStyle(.primary)
                            .lineLimit(2)
                            .minimumScaleFactor(0.9)
                    }

                    Spacer(minLength: 0)

                    Image(systemName: "chevron.right")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.tertiary)
                        .accessibilityHidden(true)
                }

                HStack(spacing: 12) {
                    Label(race.dateText, systemImage: "calendar")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .labelStyle(.titleAndIcon)

                    Label(race.locationText, systemImage: "mappin.and.ellipse")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .labelStyle(.titleAndIcon)
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(.thinMaterial)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .strokeBorder(.quaternary, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(race.title), \(race.dateText), \(race.locationText)")
        .accessibilityHint("Opens the active race.")
    }
}

struct EmptyActiveRaceCard: View {
    let onNewRace: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("info.noActiveRace")
                .font(.title3.weight(.semibold))

            Text("Create a race to get a timeline, packing checklist, and race day flow.")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Button(action: onNewRace) {
                Text("actions.newRace")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(.thinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .strokeBorder(.quaternary, lineWidth: 1)
        )
        .accessibilityElement(children: .combine)
    }
}

struct QuickActionTile: View {
    let title: String
    let systemImage: String
    let subtitle: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 10) {
                Image(systemName: systemImage)
                    .font(.title3.weight(.semibold))
                    .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.headline)
                        .foregroundStyle(.primary)

                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer(minLength: 0)
            }
            .padding(14)
            .frame(maxWidth: .infinity, minHeight: 96, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(.thinMaterial)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .strokeBorder(.quaternary, lineWidth: 1)
            )
            .contentShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
        .buttonStyle(.plain)
        .accessibilityLabel(title)
        .accessibilityHint(subtitle)
    }
}

// MARK: - Simple model placeholder

struct RaceSummary: Identifiable {
    let id = UUID()
    let title: String
    let dateText: String
    let locationText: String
}
