//
//  File.swift
//  
//
//  Created by Daniel Fortes on 02/08/23.
//

import Foundation
import iTunesLibrary

struct Album: Identifiable, Equatable {
    var id: UInt64
    var title: String
    var artist: String?
    var genre: String
}

extension Album {
    init?(from track: ITLibMediaItem) {
        guard let albumTitle = track.album.title else {
            return nil
        }
        
        self.id = track.album.persistentID.uint64Value
        self.title = albumTitle
        self.artist = track.album.albumArtist
        self.genre = track.genre
    }
}
