//
//  ContentView.swift
//  musicshit
//
//  Created by Daniel Fortes on 01/08/23.
//

import SwiftUI
import iTunesLibrary
import MusicLibraryKit

struct AlbumGridView: View {
    @EnvironmentObject var library: Library
    
    @State private var showSortPopover = false
    @State private var albumSortType: AlbumSortType = .album;
    @State private var albumSortOrder: AlbumSortOrder = .ascending;
    @State private var albumFilterText: String = ""
    
    
    var displayAlbums: [Album] {
        var albums = self.library.albums
        
        if self.albumFilterText != "" {
            albums = albums.filter {
                $0.title.localizedCaseInsensitiveContains(self.albumFilterText) ||
                $0.artist.localizedCaseInsensitiveContains(self.albumFilterText)
            }
        }
        
        let result = albums.sorted(by: self.albumSortType  == .album ? \.title : \.artist,
                                   comparator: albumSortOrder == .ascending ? (<) : (>))
        
        return result
    }

    let placeholder = NSImage(named: "placeholder")!
    var body: some View {
        
        
        ZStack(alignment: .top) {
            Color.white
            
            ScrollView {
                LazyVGrid(columns: [.init(.adaptive(minimum: 100))]) {
                    ForEach(self.displayAlbums) { album in
                        AlbumView(album: album)
                    }
                }
                .padding()
            }
            
        }
        .toolbar {
            ToolbarItem {
                Button {
                    if let album = self.displayAlbums.randomElement() {
                        playAlbum(album: album)
                    }
                } label: {
                    Image(systemName: "shuffle")
                }
                .help("Play a random album")
            }
            
            ToolbarItem {
                Menu {
                    Picker(selection: self.$albumSortType) {
                        Button("Album Title"){}.tag(AlbumSortType.album)
                        Button("Artist Name"){}.tag(AlbumSortType.artist)
                    } label: {}.pickerStyle(.inline)
                    
                    Divider()
                    
                    Picker(selection: self.$albumSortOrder) {
                        Button("Ascending"){}.tag(AlbumSortOrder.ascending)
                        Button("Descending"){}.tag(AlbumSortOrder.descending)
                    } label: {}.pickerStyle(.inline)
                } label: {
                    HStack {
                        Image(systemName: "arrow.up.arrow.down")
                        Image(systemName: "chevron.down")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 8)
                    }
                }
            }
        }
        .searchable(text: self.$albumFilterText, placement: .toolbar)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumGridView()
            .environmentObject(Library.preview())
    }
}
