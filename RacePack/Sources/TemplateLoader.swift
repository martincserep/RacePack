//
//  TemplateLoader.swift
//  RacePack
//
//  Created by Martin Cserép on 2026. 01. 05..
//

import Foundation

enum TemplateLoaderError: Error, CustomStringConvertible {
  case noTemplateFilesFound
  case failedToReadFile(URL, underlying: Error)
  case failedToDecodeFile(URL, underlying: Error)
  case validationFailed(URL, underlying: Error)

  var description: String {
    switch self {
    case .noTemplateFilesFound:
      return "No template JSON files found in Bundle subdirectory 'templates'."
    case let .failedToReadFile(url, err):
      return "Failed to read template file: \(url.lastPathComponent). Error: \(err)"
    case let .failedToDecodeFile(url, err):
      return "Failed to decode template file: \(url.lastPathComponent). Error: \(err)"
    case let .validationFailed(url, err):
      return "Template validation failed: \(url.lastPathComponent). Error: \(err)"
    }
  }
}

protocol TemplateLoading {
  func loadTemplates() throws -> [PackTemplateDTO]
}

struct BundleTemplateLoader: TemplateLoading {
  let bundle: Bundle
  let subdirectory: String

  init(bundle: Bundle = .main, subdirectory: String = "templates") {
    self.bundle = bundle
    self.subdirectory = subdirectory
  }

    func loadTemplates() throws -> [PackTemplateDTO] {
      var urls = bundle.urls(forResourcesWithExtension: "json", subdirectory: subdirectory) ?? []

      // Fallback: ha a mappa nem folder reference (kék), akkor rootba kerülnek a json-ok
      if urls.isEmpty {
        urls = bundle.urls(forResourcesWithExtension: "json", subdirectory: nil) ?? []
      }

      guard !urls.isEmpty else {
        throw TemplateLoaderError.noTemplateFilesFound
      }

      let decoder = JSONDecoder()
      var templates: [PackTemplateDTO] = []
      templates.reserveCapacity(urls.count)

      for url in urls.sorted(by: { $0.lastPathComponent < $1.lastPathComponent }) {
        let data = try Data(contentsOf: url)
        let dto = try decoder.decode(PackTemplateDTO.self, from: data)
        try dto.validate()
        templates.append(dto)
      }

      return templates
    }

}
