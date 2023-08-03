//
//  File.swift
//  
//
//  Created by Daniel Fortes on 02/08/23.
//

import Foundation
import iTunesLibrary

struct Playlist : Identifiable {
    let id = UUID()
    var persistentID: UInt64
    var name: String
    var albumCollection: AlbumCollection
}

extension Playlist {
    init?(from itunesPlaylist: ITLibPlaylist) {
             
        self.persistentID = itunesPlaylist.persistentID.uint64Value
        self.name = itunesPlaylist.name
        self.albumCollection = AlbumCollection()
        
//        print("-----------------")
//        print("\(itunesPlaylist.name): \(itunesPlaylist.distinguishedKind), \(itunesPlaylist.kind), \(itunesPlaylist.isPrimary)")
//        print("-----------------")
        
        if itunesPlaylist.distinguishedKind != .kindNone  || itunesPlaylist.isPrimary {
            return nil
        }
        
        for item in itunesPlaylist.items {
            if let album = Album(from: item) {
                self.albumCollection.add(album: album)
            }
        }
        
        if self.albumCollection.albums.isEmpty {
            return nil
        }
    }
}
