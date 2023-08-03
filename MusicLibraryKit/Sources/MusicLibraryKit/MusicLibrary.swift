//
//  File.swift
//  
//
//  Created by Daniel Fortes on 02/08/23.
//

import Foundation
import iTunesLibrary



struct MusicLibrary {
    var albumCollection: AlbumCollection
    var genreCollection: GenreCollection
    var palylists: [Playlist]
}

extension MusicLibrary {
    func view(for viewType: ViewType) -> [Album] {
        switch viewType {
        case .all:
            return self.albumCollection.albums.map{ $1 }
        case .filtered(_, _):
            //_ = playlists
            return self.albumCollection.albums.map{ $1 }
        }
    }
}




