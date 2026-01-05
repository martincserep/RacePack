//
//  BundleTemplatesDebug.swift
//  RacePack
//
//  Created by Martin Cserép on 2026. 01. 05..
//

import Foundation

struct BundleTemplatesDebug {
  static func dump(bundle: Bundle = .main, subdirectory: String = "templates") {
    print("=== BundleTemplatesDebug ===")
    print("Bundle: \(bundle.bundleURL.path)")

    if let dirURL = bundle.url(forResource: subdirectory, withExtension: nil) {
      print("Dir URL (forResource): \(dirURL.path)")
    } else {
      print("Dir URL (forResource): nil")
    }

    let urls = bundle.urls(forResourcesWithExtension: "json", subdirectory: subdirectory) ?? []
    print("urls(forResourcesWithExtension:subdirectory:) count = \(urls.count)")
    for u in urls { print(" - \(u.lastPathComponent) @ \(u.path)") }

    // fallback: keressünk MINDEN json-t a bundle rootban
    let rootJson = bundle.urls(forResourcesWithExtension: "json", subdirectory: nil) ?? []
    print("root json count = \(rootJson.count)")
    for u in rootJson { print(" - ROOT: \(u.lastPathComponent)") }

    print("===========================")
  }
}
