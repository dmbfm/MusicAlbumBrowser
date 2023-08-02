//
//  ContentView.swift
//  musicshit
//
//  Created by Daniel Fortes on 01/08/23.
//

import SwiftUI
import iTunesLibrary


struct AlbumGridView: View {
    @EnvironmentObject var library: Library
    
    @State private var showSortPopover = false
    
    let placeholder = NSImage(named: "placeholder")!
    var body: some View {
        
        
        ZStack(alignment: .top) {
            Color.white
            
            ScrollView {
                LazyVGrid(columns: [.init(.adaptive(minimum: 100))]) {
                    ForEach(self.library.sortedAlbums) { album in
                        AlbumView(album: album)
                    }
                }
                .padding()
            }
            
        }
        .onAppear {
            do {
                try self.library.fetchAlbums()
                try self.library.fetchPlaylists()
            } catch {
                print(error.localizedDescription)
            }
        }
        .toolbar {
            ToolbarItem {
                Button {
                    if let album = self.library.sortedAlbums.randomElement() {
                        playAlbum(albumName: album.title)
                    }
                } label: {
                    Image(systemName: "shuffle")
                }
                
            }
            ToolbarItem(placement: .automatic) {
                
             
                Menu {
                    
                    Picker(selection: self.$library.sortType) {
                        Button("Album"){}.tag(SortType.album)
                        Button("Artist"){}.tag(SortType.artist)
                    } label: {}.pickerStyle(.inline)
                    
                    Divider()
                    
                    Picker(selection: self.$library.sortTypeSecond) {
                        
                        if self.library.sortType != .album {
                            Button("Album"){}
                                .tag(SortType.album)
                        }

                        if self.library.sortType != .artist {
                            Text("Artist")
                                .tag(SortType.artist)
                        }
                            
                    } label: {}.pickerStyle(.inline)
                    
                    Divider()
                    
                    Picker(selection: self.$library.sortOrder) {
                        Button("Ascending"){}.tag(Foundation.SortOrder.forward)
                        Button("Descending"){}.tag(Foundation.SortOrder.reverse)
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
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumGridView()
            .environmentObject(Library.preview())
    }
}
