//
//  musicshitApp.swift
//  musicshit
//
//  Created by Daniel Fortes on 01/08/23.
//

import SwiftUI


@main
struct MusicAlbumsBrowser: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(Library())
        }
    }
}
