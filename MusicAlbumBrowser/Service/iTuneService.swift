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
            
            if result[id] == nil {

                result[id] = Album(id: id,
                                   title: album.title ?? "Untitled",
                                   albumArtist: album.albumArtist,
                                   artwork: item.artwork?.image?.resized(to: NSSize(width: 100, height: 100)),
                                   genre: item.genre)
            }
            
        }
        
        return result.map { $1 }
    }
    
}
