//
//  AlbumCollection.swift
//  MusicAlbumBrowser
//
//  Created by Daniel Fortes on 02/08/23.
//

import Foundation
//
//enum LibraryViewType {
//    case all
//    case collections([UUID])
//}
//
//struct AlbumLibrary {
//    var libraryCollection = AlbumCollection(kind: .library)
//    var playlistCollections: [AlbumCollection] = []
//    
//    var viewType: LibraryViewType = .all
//    
//    var view: AlbumCollection {
//        switch viewType {
//        case .all:
//            return libraryCollection
//        case .collections(let array):
//            
//        }
//    }
//}
//
//
//
//struct AlbumCollection: Identifiable {
//    public enum Kind {
//        case library
//        case playlist
//    }
//    
//    var id = UUID()
//    var albums: [Int: Album]
//    let kind: Kind
//    
//    init(albums: [Int : Album] = [:], kind: Kind = .library) {
//        self.albums = albums
//        self.kind = kind
//    }
//    
//    mutating func add(album: Album) {
//        if self.albums[album.id] == nil {
//            self.albums[album.id] = album
//        }
//    }
//    
//    mutating func merge(with collection: AlbumCollection) {
//        for (_, album) in collection.albums {
//            self.add(album: album)
//        }
//    }
//}
