//
//  iTuneService.swift
//  musicshit
//
//  Created by Daniel Fortes on 01/08/23.
//

import Foundation
import iTunesLibrary
import MusicKit

class iTunesService {
    
    var library: ITLibrary
    
    init() throws {
        self.library = try ITLibrary(apiVersion: "1.0")
    }
    
    func fetchAlbums() -> [Album] {
        
        var result: [Int:Album] = [:]
        
        for item in self.library.allMediaItems {
            let album = item.album
            let id = Int(album.persistentID.intValue)
            
            if item.mediaKind != .kindSong {
                continue
            }
            
            if result[id] == nil {
                result[id] = Album(from: item)
            }
        }
        
        return result.map { $1 }
    }
    
    func fetchPlaylists() -> [Playlist] {
        var result: [Playlist] = []
        for playlist in self.library.allPlaylists {
                        
            var albums: [Int:Album] = [:]
            
            for item in playlist.items {

                if item.mediaKind != .kindSong {
                    continue
                }
                
                let album = item.album
                let id = Int(album.persistentID.intValue)
                
                if albums[id] == nil {
                    albums[id] = Album(from: item)
                }
                
            }
            
            if albums.isEmpty {
                continue
            }
            
            result.append(Playlist(name: playlist.name, albums: albums.map( \.value ).sorted(by: { $0.title < $1.title })))
        }
        
        return result
    }
    
}
