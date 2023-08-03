//
//  PreviewData.swift
//  MusicAlbumBrowser
//
//  Created by Daniel Fortes on 03/08/23.
//

import Foundation
import AppKit
import MusicLibraryKit

class PreviewData {
    
    static let previewAlbum = Album(id: 1,
                                    title: "2001",
                                    artist: "Dr. Dre",
                                    genre: "RAP",
                                    year: 2001,
                                    artwork: NSImage(named: "dr_dre_2001")!.resized(to: NSSize(width: 100, height: 100)),
                                    originalArtwork: NSImage(named: "dr_dre_2001")!)
    
}
