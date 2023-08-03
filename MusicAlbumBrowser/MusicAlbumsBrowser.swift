//
//  musicshitApp.swift
//  musicshit
//
//  Created by Daniel Fortes on 01/08/23.
//

import SwiftUI
import MusicLibraryKit

class GlobalState: ObservableObject {
    @Published var detailAlbum: Album? = nil
}

@main
struct MusicAlbumsBrowser: App {
    
    @StateObject var library = try! Library()
    @StateObject var globalState = GlobalState()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(library)
                .environmentObject(globalState)
        }
        
        Window("", id: "detail") {
            AlbumInfoWindowView(album: self.globalState.detailAlbum)
        }
        .windowResizability(.contentSize)
    }
}
