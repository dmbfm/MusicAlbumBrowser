//
//  Album.swift
//  musicshit
//
//  Created by Daniel Fortes on 01/08/23.
//

import Foundation
import AppKit
import iTunesLibrary

struct Album: Identifiable {
    var id: Int
    var title: String
    var albumArtist: String?
    var artwork: NSImage?
    var genre: String
}

extension Album {
    init?(from mediaItem: ITLibMediaItem) {
        guard let albumTitle = mediaItem.album.title else {
            return nil
        }
        
        self.id = Int(mediaItem.persistentID.intValue)
        self.title = albumTitle
        self.albumArtist = mediaItem.album.albumArtist
        self.artwork = mediaItem.artwork?.image?.resized(to: NSSize(width: 100, height: 100))
        self.genre = mediaItem.genre
    }
}
