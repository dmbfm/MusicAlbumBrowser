//
//  Tag.swift
//  MusicAlbumBrowser
//
//  Created by Daniel Fortes on 04/08/23.
//

import Foundation
import MusicLibraryKit

struct Tag: Identifiable, Codable {
    var id = UUID()
    var name: String
    var albumSet: Set<UInt64> = Set()
}

