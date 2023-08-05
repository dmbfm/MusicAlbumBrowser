//
//  SharedState.swift
//  MusicAlbumBrowser
//
//  Created by Daniel Fortes on 05/08/23.
//

import Foundation
import MusicLibraryKit

class SharedState: ObservableObject {
    @Published var detailAlbum: Album? = nil
}
