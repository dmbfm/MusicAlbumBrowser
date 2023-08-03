//
//  MainView.swift
//  musicshit
//
//  Created by Daniel Fortes on 01/08/23.
//

import SwiftUI
import MusicLibraryKit

let allAlbumsUUID = UUID()

struct MainView: View {
    
    @EnvironmentObject var library: Library
    
    @State private var selectedNavigationItems: Set<UUID> = [Library.allItemsUUID]
    @State private var genreFilterString: String = ""
    
    var displayGenres: [Genre] {
        self.library.genres.filter { genre in
            if self.genreFilterString == "" {
                return true
            }
            
            return genre.name.localizedCaseInsensitiveContains(self.genreFilterString)
        }.sorted(by: { $0.name < $1.name })
    }
    
    var body: some View {
        NavigationSplitView {
            List(selection: self.$selectedNavigationItems) {
                HStack {
                    Image(systemName: "music.note.house.fill")
                        .foregroundColor(.pink)
                    
                    Text("All Albums")
                }
                .tag(Library.allItemsUUID)
                
                Section("Genres") {
                    HStack {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                        ZStack(alignment: .trailing) {
                            TextField("",
                                      text: self.$genreFilterString,
                                      prompt: Text("Filter Genres..."))
                            .textFieldStyle(.roundedBorder)
                            .padding(.leading, -10)
                            
                            Button {
                                self.genreFilterString = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                            }
                            .buttonStyle(.plain)
                            .foregroundColor(.gray)
                            .clipShape(Rectangle())
                            .offset(x: -6)
                        }
                    }
                    
                    ForEach(self.displayGenres) { genre in

                        HStack {
                            Image(systemName: "music.quarternote.3")
                                .foregroundColor(.pink)
                            Text(genre.name)
                        }
                        .tag(genre.id)
                    }
                }
                
//                Section("Playlists") {
//                    ForEach(self.library.playlists) { playlist in
//                        HStack {
//                            Image(systemName: "music.note.list")
//                                .foregroundColor(.pink)
//                            Text(playlist.name)
//                        }
//                    }
//                }
            }
        } detail: {
            AlbumGridView()
        }
        .onChange(of: self.selectedNavigationItems) { newValue in
            if self.selectedNavigationItems.contains(Library.allItemsUUID) {
                self.selectedNavigationItems = [Library.allItemsUUID]
            } else {
                //self.library.albumFilter = .genre(<#T##[String]#>)
            }
            
            self.library.updateView(self.selectedNavigationItems)
            
        }
        .searchable(text: .constant("Two!"), placement:  .toolbar)
        .onAppear {
            Task {
                await self.library.fetchLibrary()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(Library.preview())
    }
}
