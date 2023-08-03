//
//  File.swift
//  
//
//  Created by Daniel Fortes on 02/08/23.
//

import Foundation
import iTunesLibrary

struct iTunesService {
    var library: ITLibrary
    
    init() throws {
        try self.library = ITLibrary(apiVersion: "1.0")
    }
    
    func fetchLibraryAlbums() -> AlbumCollection {
        return AlbumCollection(from: self.library.allMediaItems)
    }
    
    func fetchPlaylists() -> PlaylistCollection {
        var result = PlaylistCollection()
        
        for playlist in self.library.allPlaylists {
            if let playlist = Playlist(from: playlist) {
                result.add(playlist)
            }
        }
        
        return result
    }
}


