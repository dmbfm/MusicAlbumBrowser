//
//  musicshitApp.swift
//  musicshit
//
//  Created by Daniel Fortes on 01/08/23.
//

import SwiftUI
import MusicLibraryKit


@main
struct MusicAlbumsBrowser: App {
    
    @StateObject var library = try! Library()
    @StateObject var tagProvider = TagProvider.shared
    @StateObject var globalState = SharedState()
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            SidebarView()
                .environmentObject(library)
                .environmentObject(globalState)
                .environmentObject(tagProvider)
        }
        
        Window("", id: "detail") {
                    AlbumInfoWindowView(album: self.globalState.detailAlbum)
                .frame(minWidth: 512, minHeight: 612)
        }
        .windowResizability(.contentSize)
    }
}
