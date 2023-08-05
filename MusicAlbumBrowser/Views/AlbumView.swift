//
//  AlbumView.swift
//  musicshit
//
//  Created by Daniel Fortes on 01/08/23.
//

import SwiftUI
import MusicLibraryKit

struct AlbumView: View {
    
    let album: Album
    
    @State private var hovered = false
    @State private var playSymbolHovered = false
    
    @Environment(\.openWindow) private var openWindow
    
    @EnvironmentObject var globalState: GlobalState
    @EnvironmentObject var tagProvider: TagProvider
    
    var body: some View {
        VStack(alignment: .center) {
            //if let nsimage = album.artwork {
                Button {
                    playAlbum(album: album)
                } label: {
                    ZStack {
                        if let nsimage = album.artwork {
                            Image(nsImage: nsimage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                                .colorMultiply(hovered ? .init(white: 0.5) : .white)
                                .clipped()
                                .cornerRadius(4)
                                .shadow(radius: 2)
                        } else {
                            ZStack {
                                
                                LinearGradient(stops: [
                                    .init(color: .white, location: -0.4),
                                    .init(color: .pink, location: 1)
                                ],
                                               startPoint: .top,
                                               endPoint: .bottom)
                                
                                Image(systemName: "opticaldisc.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(25)
                                    .foregroundStyle(.secondary)
                            }
                            .cornerRadius(4)
                            .shadow(radius: 2)
                            .frame(width: 100, height: 100)
                        }
                        
                        if hovered {
                            
                            ZStack {
                                if self.playSymbolHovered {
                                    Image(systemName: "play.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .symbolRenderingMode(.hierarchical)
                                        .foregroundStyle(.red)
                                } else {
                                    Image(systemName: "play.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .symbolRenderingMode(.hierarchical)
                                        .foregroundStyle(.regularMaterial)
                                }
                            }
                            .frame(width: 50, height: 50)
                            .onHover { value in
                                self.playSymbolHovered = value
                            }
                        }
                    }
                    .onHover { value in
                        self.hovered = value
                        
                        if self.hovered {
                            self.playSymbolHovered = false
                        }
                    }
                    .frame(height: 100)
                }
                .buttonStyle(.plain)
            //}
            Button {
                globalState.detailAlbum = album
                openWindow(id: "detail")
            } label: {
                VStack {
                    Text(album.title)
                    Text(album.artist)
                        .font(.caption)
                }
            }.buttonStyle(.plain)
            Spacer()
        }
        .frame(height: 150)
        .contextMenu {
            //Text("Tags: \(self.albumTags.count)")
            Text("Tags")
            Divider()
            ForEach(self.tagProvider.tags) { tag in
                let hasTag = tag.albumSet.contains(self.album.id)
                Button {
                    
                    if hasTag {
                        var _tag = tag
                        _tag.albumSet.remove(self.album.id)
                        self.tagProvider.updateTag(tag: _tag)
                    } else {
                        var _tag = tag
                        _tag.albumSet.insert(album.id)
                        self.tagProvider.updateTag(tag: _tag)
                    }
 
                    
                    //self.tagProvider.storage.addTagsToAlbum(id: album.id, title: album.title, tags: [tag])
                } label: {
                    HStack {
                        
                        if hasTag {
                            Image(systemName: "checkmark")
                        }
                        
                        Text(tag.name)
                    }
                }
            }
        }
        .onAppear {
            //self.albumTags = tagsProvider.getTags(forAlbum: album)
        }
    }
}

struct AlbumView_Previews: PreviewProvider {
    
    static let nsimage = NSImage(named: "dr_dre_2001")!
    
    static var previews: some View {
        AlbumView(album: Album(id: 1, title: "2001", artist: "Dr. Dre", genre: "Rap", year: 2001))
    }
}
