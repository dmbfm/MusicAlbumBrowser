//
//  Playlist.swift
//  MusicAlbumBrowser
//
//  Created by Daniel Fortes on 02/08/23.
//

import Foundation

struct Playlist: Identifiable {
    var id = UUID()
    var name: String
    var albums: [Album]
}
