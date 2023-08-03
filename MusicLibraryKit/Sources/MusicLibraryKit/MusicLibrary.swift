//
//  File.swift
//  
//
//  Created by Daniel Fortes on 02/08/23.
//

import Foundation
import iTunesLibrary

public struct MusicLibrary {
    public var albumCollection: AlbumCollection
    public var genreCollection: GenreCollection
    public var playlistCollection: PlaylistCollection
}

public extension MusicLibrary {
    init() {
        self.albumCollection = AlbumCollection()
        self.genreCollection = GenreCollection()
        self.playlistCollection = PlaylistCollection()
    }
}

public extension MusicLibrary {
    init(service: iTunesService) {
        self.albumCollection = service.fetchLibraryAlbums()
        self.genreCollection = GenreCollection(from: self.albumCollection)
        self.playlistCollection = service.fetchPlaylists()
    }
}

public extension MusicLibrary {
    func view(for viewType: ViewType) -> [Album] {
        switch viewType {
        
        case .all:
            return self.albumCollection.albums.map{ $1 }
            
        case .filtered(genres: let genres, playlists: let playlists):
            
            var result = AlbumCollection()
            
            for genreID in genres {
                if let genre = self.genreCollection.genres[genreID] {
                    result = result.merge(with: self.albumCollection.filtered(byGenre: genre.name))
                }
            }
            
            for playlistID in playlists {
                if let playlist = self.playlistCollection.playlists[playlistID] {
                    result = result.merge(with: playlist.albumCollection)
                }
            }
            
            return result.albums.map { $1 }
        }
    }
}




