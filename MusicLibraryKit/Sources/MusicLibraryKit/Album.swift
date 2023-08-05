//
//  File.swift
//  
//
//  Created by Daniel Fortes on 02/08/23.
//

import Foundation
import iTunesLibrary
import AppKit
import Shared

public struct Album: Identifiable, Equatable, Hashable {
    public var id: UInt64
    public var title: String
    public var artist: String
    public var genre: String
    public var year: Int
    public var artwork: NSImage?
    public var originalArtwork: NSImage?
    
    public init(id: UInt64, title: String, artist: String? = nil, genre: String, year: Int, artwork: NSImage? = nil, originalArtwork: NSImage? = nil) {
        self.id = id
        self.title = title
        self.artist = artist ?? ""
        self.genre = genre
        self.year = year
        self.artwork = artwork
        self.originalArtwork = originalArtwork
    }
}

public extension Album {
    init?(from track: ITLibMediaItem) {
        guard let albumTitle = track.album.title else {
            return nil
        }
        
        self.id = track.album.persistentID.uint64Value
        self.title = albumTitle
        self.artist = track.album.albumArtist ?? "Various Artists"
        self.genre = track.genre
        self.year = track.year
        self.originalArtwork = track.artwork?.image
        self.artwork = track.artwork?.image?.resized(to: NSSize(width: 100, height: 100))
    }
}
