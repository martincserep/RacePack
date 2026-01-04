//
//  Item.swift
//  RacePack
//
//  Created by Martin Cserép on 2026. 01. 04..
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
