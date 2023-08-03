//
//  File.swift
//  
//
//  Created by Daniel Fortes on 02/08/23.
//

import Foundation
import iTunesLibrary

public struct AlbumCollection {
    public var albums: [UInt64:Album]
}

extension AlbumCollection {
    init(_ albums: [UInt64:Album] = [:]) {
        self.albums = albums
    }
}

extension AlbumCollection {

    init(from mediaItems: [ITLibMediaItem]) {
        self.albums = [:]
        
        for item in mediaItems {
            let id = item.album.persistentID.uint64Value
            
            if self.albums[id] == nil, let album = Album(from: item) {
                self.albums[id] = album
            }
        }
    }
}

extension AlbumCollection {
    public mutating func add(album: Album) {
        if self.albums[album.id] == nil {
            self.albums[album.id] = album
        }
    }
}

extension AlbumCollection {
    public func merge(with collection: AlbumCollection) -> AlbumCollection {
        var result = self
        
        for (_, album) in collection.albums {
            result.add(album: album)
        }
        
        return result
    }
}

extension AlbumCollection {
    public func filtered(byGenre genre: String) -> AlbumCollection {
        let albums = self.albums.filter({ $1.genre == genre })
        return AlbumCollection(albums: albums)
    }
}
