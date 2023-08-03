//
//  MainView.swift
//  musicshit
//
//  Created by Daniel Fortes on 01/08/23.
//

import SwiftUI

let allAlbumsUUID = UUID()

struct MainView: View {
    
    @EnvironmentObject var library: Library
    
    @State private var selectedNavigationItems: Set<UUID> = []
    @State private var genreFilterString: String = ""
    
    var body: some View {
        NavigationSplitView {
            List(selection: self.$selectedNavigationItems) {
                HStack {
                    Image(systemName: "music.note.house.fill")
                        .foregroundColor(.pink)
                    
                    Text("All Albums")
                }
                .tag(allAlbumsUUID)
                
                Section("Genres") {
                    HStack {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                        ZStack(alignment: .trailing) {
                            TextField("",
                                      text: .constant(""), //self.$library.genresFilterString,
                                      prompt: Text("Filter Genres..."))
                            .textFieldStyle(.roundedBorder)
                            .padding(.leading, -10)
                            
                            Button {
                                //self.library.genresFilterString = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                            }
                            .buttonStyle(.plain)
                            .foregroundColor(.gray)
                            .clipShape(Rectangle())
                            .offset(x: -6)
                        }
                    }
                    
                    //ForEach(self.library.filteredGenres.sorted(by: { $0.name < $1.name })) { genre in
                    ForEach(self.library.genres.sorted(by: { $0.name < $1.name })) { genre in

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
            
            if self.selectedNavigationItems.contains(allAlbumsUUID) {
                self.selectedNavigationItems = [allAlbumsUUID]
                //self.library.albumFilter = .none
            } else {
                //self.library.albumFilter = .genre(<#T##[String]#>)
            }
            
            
            
            //            if self.selectedGenre.contains("") {
            //                self.selectedGenre = [""]
            //                self.library.albumFilter = .none
            //            } else {
            //                self.library.albumFilter = .genre(self.selectedGenre.sorted())
            //            }
            //
            //self.library.sortAndFilter()
            
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
