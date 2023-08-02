//
//  MainView.swift
//  musicshit
//
//  Created by Daniel Fortes on 01/08/23.
//

import SwiftUI


struct MainView: View {
    
    @EnvironmentObject var library: Library

    @State private var selectedGenre: Set<String> = [""]
    @State private var genreFilterString: String = ""
    
    var body: some View {
        NavigationSplitView {
            List(selection: self.$selectedGenre) {
                
                HStack {
                    Image(systemName: "music.note.house.fill")
                        .foregroundColor(.pink)

                    Text("All Albums")
                        
                }
                .tag("")
                   
                Section("Genres") {
                    
                    HStack {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                        ZStack(alignment: .trailing) {
                            TextField("",
                                      text: self.$library.genresFilterString,
                                      prompt: Text("Filter Genres..."))
                            .textFieldStyle(.roundedBorder)
                            .padding(.leading, -10)
                            
                            Button {
                                self.library.genresFilterString = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                            }
                            .buttonStyle(.plain)
                            .foregroundColor(.gray)
                            .clipShape(Rectangle())
                            .offset(x: -6)
                        }
                    }
                    
                    ForEach(self.library.filteredGenres.sorted(), id: \.self) { genre in
                        HStack {
                            Image(systemName: "music.quarternote.3")
                                .foregroundColor(.pink)
                            Text(genre)
                        }
                    }
                    
                }
            }
        } detail: {
            AlbumGridView()
        }
        .onChange(of: self.selectedGenre) { newValue in
            if self.selectedGenre.contains("") {
                self.selectedGenre = [""]
                self.library.albumFilter = .none
            } else {
                self.library.albumFilter = .genre(self.selectedGenre.sorted())
            }
            
            self.library.sortAndFilter()
            
        }
//        .onChange(of: self.selectedGenre) { newValue in
//            if let genre = newValue, genre != "" {
//                self.library.albumFilter = .genre([genre])
//            } else {
//                self.library.albumFilter = .none
//            }
//
//            self.library.sortAndFilter()
//        }
//        .onChange(of: self.genreFilterString) { newValue in
//            self.library.genresFilterString =
//        }
        .searchable(text: .constant("Two!"), placement:  .toolbar)
    }
    
}

struct MainView_Previews: PreviewProvider {
        static var previews: some View {
        MainView()
            .environmentObject(Library.preview())
    }
}
