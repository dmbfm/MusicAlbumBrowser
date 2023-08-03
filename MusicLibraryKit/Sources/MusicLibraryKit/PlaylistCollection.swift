//
//  File.swift
//  
//
//  Created by Daniel Fortes on 03/08/23.
//

import Foundation

public struct PlaylistCollection {
    public var playlists: [UUID:Playlist] = [:]
}

extension PlaylistCollection {
    public mutating func add(_ playlist: Playlist) {
        if self.playlists[playlist.id] == nil {
            self.playlists[playlist.id] = playlist
        }
    }
}
