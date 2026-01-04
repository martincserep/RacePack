//
//  PackDetailView.swift
//  RacePack
//
//  Created by Martin Cserép on 2026. 01. 05..
//

import SwiftUI
import SwiftData

struct PackDetailView: View {
  @Environment(\.modelContext) private var context
  @Bindable var pack: Pack

  var body: some View {
    List {
      Section("Items") {
        ForEach(pack.items.sorted { $0.sortOrder < $1.sortOrder }) { item in
          HStack {
            Button {
              toggle(item)
            } label: {
              Image(systemName: item.isPacked ? "checkmark.circle.fill" : "circle")
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading) {
              Text(item.name)
              Text(item.categoryRaw).font(.footnote).foregroundStyle(.secondary)
            }
            Spacer()
            Text("×\(item.quantity)").foregroundStyle(.secondary)
          }
        }
        .onDelete(perform: deleteItems)
      }
    }
    .navigationTitle(pack.title)
    .toolbar {
      Button {
        addItem()
      } label: { Image(systemName: "plus") }
    }
  }

  private func addItem() {
    let repo = SwiftDataPackRepository(context: context)
    do { _ = try repo.addItem(to: pack, name: "Sunglasses", category: .essentials, quantity: 1) }
    catch { print("Add item failed: \(error)") }
  }

  private func toggle(_ item: PackItem) {
    let repo = SwiftDataPackRepository(context: context)
    do { try repo.togglePacked(item) }
    catch { print("Toggle failed: \(error)") }
  }

  private func deleteItems(_ indexSet: IndexSet) {
    let sorted = pack.items.sorted { $0.sortOrder < $1.sortOrder }
    let repo = SwiftDataPackRepository(context: context)
    for i in indexSet {
      do { try repo.deleteItem(sorted[i]) }
      catch { print("Delete item failed: \(error)") }
    }
  }
}
