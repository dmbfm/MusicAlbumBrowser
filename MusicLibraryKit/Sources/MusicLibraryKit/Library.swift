//
//  File.swift
//  
//
//  Created by Daniel Fortes on 02/08/23.
//

import Foundation
import iTunesLibrary

enum ViewType {
    case all
    case filtered(genres: [UUID], playlists: [UUID])
}

struct MusicLibrary {
    var albums: AlbumCollection
    var genres: GenreCollection
    var palylists: [Playlist]
}

extension MusicLibrary {
    func view(for type: ViewType) -> [Album] {
        []
    }
}

struct Genre: Identifiable {
    var id: UUID
    var name: String
}

struct GenreCollection {
    var genres: [UUID: Genre] = [:]
}

extension GenreCollection {
    init(from albumCollection: AlbumCollection) {
        var genreSet = Set<String>()
        
        for (_, album) in albumCollection.albums {
            genreSet.insert(album.genre)
        }
        
        for genre in genreSet {
            let id = UUID()
            self.genres[UUID()] = Genre(id: id, name: genre )
        }
    }
}

struct AlbumCollection {
    var albums: [Int:Album]
}

extension AlbumCollection {
    init(from mediaItems: [ITLibMediaItem]) {
        self.albums = [:]
        
        for item in mediaItems {
            let id = item.album.persistentID.intValue
            
            if self.albums[id] == nil, let album = Album(from: item) {
                self.albums[id] = album
            }
        }
    }
}

struct Playlist : Identifiable {
    let id = UUID()
    var persistentID: Int
    var name: String
    var albumCollection: AlbumCollection
}

struct iTunesService {
    var library: ITLibrary
    
    init() throws {
        try self.library = ITLibrary(apiVersion: "1.0")
    }
    
    func fetchLibraryAlbums() -> AlbumCollection {
        return AlbumCollection(from: self.library.allMediaItems)
    }
    
    func fetchPlaylists() -> [Playlist] {
        var result: [Playlist] = []
        
        for playlist in self.library.allPlaylists {
            result.append(Playlist(persistentID: playlist.persistentID.intValue,
                                   name: playlist.name, albumCollection:
                                    AlbumCollection(from: playlist.items)))
        }
        
        return result
    }
}

struct Album: Identifiable, Equatable {
    var id: Int
    var title: String
    var artist: String?
    var genre: String
}

extension Album {
    init?(from track: ITLibMediaItem) {
        guard let albumTitle = track.album.title else {
            return nil
        }
        
        self.id = track.album.persistentID.intValue
        self.title = albumTitle
        self.artist = track.album.albumArtist
        self.genre = track.genre
    }
}
