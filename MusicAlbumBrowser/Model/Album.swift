//
//  Album.swift
//  musicshit
//
//  Created by Daniel Fortes on 01/08/23.
//

import Foundation
import AppKit

struct Album: Identifiable {
    var id: Int
    var title: String
    var albumArtist: String?
    var artistID: String?
    var artwork: NSImage?
    var genre: String
}
