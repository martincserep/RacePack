//
//  RacesListView.swift
//  RacePack
//
//  Created by Martin Cserép on 2026. 01. 05..
//
import SwiftUI
import SwiftData

struct PacksListView: View {
  @EnvironmentObject private var router: AppRouter

    @Environment(\.modelContext) private var context
    @Query(sort: \Pack.updatedAt, order: .reverse) private var packs: [Pack]

    var body: some View {
      NavigationStack {
        List {
          ForEach(packs) { pack in
            NavigationLink(pack.title) {
              PackDetailView(pack: pack)
            }
          }
          .onDelete(perform: delete)
        }
        .navigationTitle("tab.packs")
        .toolbar {
          Button {
            createPack()
          } label: { Image(systemName: "plus") }
        }
      }
    }

    private func createPack() {
      let repo = SwiftDataPackRepository(context: context)
      do {
        _ = try repo.createPack(title: "New Pack", isTemplate: false, race: nil)
      } catch {
        // ide mehet egy toast / alert
        print("Create failed: \(error)")
      }
    }

    private func delete(_ indexSet: IndexSet) {
      let repo = SwiftDataPackRepository(context: context)
      for i in indexSet {
        do { try repo.deletePack(packs[i]) }
        catch { print("Delete failed: \(error)") }
      }
    }
}
