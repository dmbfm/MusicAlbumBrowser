//
//  Genre.swift
//  MusicAlbumBrowser
//
//  Created by Daniel Fortes on 02/08/23.
//

import Foundation

struct Genre: Identifiable, Hashable {
    let uuid = UUID()
    var id: String { name }
    var name: String
}
