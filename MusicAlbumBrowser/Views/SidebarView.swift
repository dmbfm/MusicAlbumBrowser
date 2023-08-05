//
//  MainView.swift
//  musicshit
//
//  Created by Daniel Fortes on 01/08/23.
//

import SwiftUI
import MusicLibraryKit

let allAlbumsUUID = UUID()

struct SidebarView: View {
    
    @EnvironmentObject var library: Library
    @EnvironmentObject var tagProvider: TagProvider
    
    
    @State private var selectedNavigationItems: Set<UUID> = [Library.allItemsUUID]
    @State private var genreFilterString: String = ""
    @State private var showCreateTagModal = false
    @State private var showDeleteTagAlert = false
    @State private var tagToDelete: Tag? = nil
    
    var displayGenres: [Genre] {
        self.library.genres.filter { genre in
            if self.genreFilterString == "" {
                return true
            }
            
            return genre.name.localizedCaseInsensitiveContains(self.genreFilterString)
        }.sorted(by: { $0.name < $1.name })
    }
    
    var tagsSection: some View {
        Section {
            ForEach(self.tagProvider.tags) { tag in
                    HStack {
                        Image(systemName: "number")
                            .foregroundColor(.pink)
                        Text(tag.name)
                        Text("\(tag.albumSet.count)")
                    }
                    .contextMenu {
                        Button("Create Tag...") {
                            self.showCreateTagModal = true
                        }
                        Button("Delete Tag...") {
                            self.tagToDelete = tag
                            self.showDeleteTagAlert = true
                        }
                    }
                    .tag(tag.id)
                    
            }
        } header: {
            Text("Tags")
                .contextMenu {
                    Button("Create Tag...") {
                        self.showCreateTagModal = true
                    }
                }
        }

        
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
                
                tagsSection
                
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
        .sheet(isPresented: self.$showCreateTagModal) {
            CreateTagModal(showModal: self.$showCreateTagModal) { tagName in
                self.addTag(named: tagName)
            }
        }
        .alert("Delete Tag", isPresented: self.$showDeleteTagAlert) {
            Button("Delete", role: .destructive) {
                if let tag = self.tagToDelete {
                    self.tagProvider.removeTag(tag: tag)
                    self.tagToDelete = nil
                }
            }
            Button("Cancel", role: .cancel) {}
        }
        .onAppear {
            self.library.fetchLibrary()
            self.tagProvider.fetchTags()
        }
    }
    
    func addTag(named name: String) {
        self.tagProvider.addTag(named: name)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
            .environmentObject(Library.preview())
    }
}
