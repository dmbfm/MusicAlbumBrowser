//
//  PlayAlbumThread.swift
//  musicshit
//
//  Created by Daniel Fortes on 01/08/23.
//

import Foundation
import MusicLibraryKit

func playAlbum(album: Album) {
    let task = PlayAlbumThread(albumName: album.title, albumYear: album.year)
    task.start()
}

class PlayAlbumThread: Thread {
    
    let albumName: String
    let albumYear: Int
    
    init(albumName: String, albumYear: Int) {
        self.albumName = albumName
        self.albumYear = albumYear
    }
    
    override func main() {
        
        let playlistName = "MusicAlbumBrowserPlaylist"
        
        let src2 = """
        tell application "Music"
            

            delete tracks of playlist "\(playlistName)"
            delay(0.1)
            
        
            set albumName to "\(albumName)"
            set playListName to "\(playlistName)"
            set refTracks to (a reference to (tracks where album = albumName and year = \(albumYear)))
            
            set nTracks to count of refTracks
            if 0 < nTracks then
                if exists (playlist playListName) then
                    set refPlayList to playlist playListName
                else
                    set refPlayList to (make new playlist with properties {name:playListName})
                end if
                
                duplicate refTracks to end of refPlayList
                ("Added " & nTracks as text) & " tracks to playlist: " & playListName
        
                play playlist playListName
            else
                "No tracks found with album name: " & albumName
            end if
        end tell
        """

        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: src2) {
            scriptObject.executeAndReturnError(&error)
            if let error = error {
                print(error)
            }
        }
    }
}
