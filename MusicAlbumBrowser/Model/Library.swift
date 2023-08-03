//
//  Library.swift
//  musicshit
//
//  Created by Daniel Fortes on 01/08/23.
//

import Foundation
import AppKit
import MusicLibraryKit

class Library: ObservableObject {
    @Published var albums: [Album] = []
    @Published var genres: [Genre] = []
    
    var view: ViewType = .all
    
    static let allItemsUUID = UUID()
    
    let service: iTunesService
    var musicLibrary: MusicLibrary! = nil
    
    init() throws {
        self.service = try iTunesService()
    }
    
    func fetchLibrary() async {
        let task = Task{ @MainActor in
            self.musicLibrary = MusicLibrary(service: self.service)
            self.genres = self.musicLibrary.genreCollection.genres.map { $1 }
            self.albums = self.musicLibrary.view(for: self.view)
        }
        _ = await task.value
    }
    
    func updateView(_ selection: Set<UUID>) {
        
        if selection.contains(Self.allItemsUUID) {
            self.view = .all
        } else {
            
            var genreUUIDs: [UUID] = []
            
            for uuid in selection {
                if self.musicLibrary.genreCollection.genres[uuid] != nil {
                    genreUUIDs.append(uuid)
                }
            }
            
            self.view = .filtered(genres: genreUUIDs, playlists: [])
        }
        
        self.albums = self.musicLibrary.view(for: self.view)
    }
}

extension Library {
    static func preview() -> Library {
        let library = try! Library()
        return library
    }
}
