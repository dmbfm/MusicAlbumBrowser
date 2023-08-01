//
//  PlayAlbumThread.swift
//  musicshit
//
//  Created by Daniel Fortes on 01/08/23.
//

import Foundation

func playAlbum(albumName: String) {
    let task = PlayAlbumThread(albumName: albumName)
    task.start()
}

class PlayAlbumThread: Thread {
    
    let albumName: String
    
    init(albumName: String) {
        self.albumName = albumName
    }
    
    override func main() {
        
        let src = """
        tell application "Music"
             play (every track of playlist "Library" whose album is "\(albumName)")
        end tell
        """
        
        let src2 = """
        tell application "Music"
            set albumName to "\(albumName)"
            set playListName to "Musicshit Playlist"
            delete playlist playListName
            set refTracks to (a reference to (tracks where album = albumName))
            
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
        
        
        
        print(src)
        if let scriptObject = NSAppleScript(source: src2) {
            scriptObject.executeAndReturnError(&error)
            //print(error)
        }
    }
}
