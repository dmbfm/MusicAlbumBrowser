//
//  AlbumView.swift
//  musicshit
//
//  Created by Daniel Fortes on 01/08/23.
//

import SwiftUI

struct AlbumView: View {
    
    let album: Album
    
    @State private var hovered = false
    @State private var playSymbolHovered = false
    
    var body: some View {
        VStack(alignment: .center) {
            //if let nsimage = album.artwork {
                Button {
                    playAlbum(albumName: album.title)
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
            Text(album.title)
            Text(album.albumArtist ?? "Various Artists")
                .font(.caption)
            Spacer()
        }
        .frame(height: 150)
    }
}

struct AlbumView_Previews: PreviewProvider {
    
    static let nsimage = NSImage(named: "dr_dre_2001")!
    
    static var previews: some View {
        AlbumView(album: Album(
            id: 1,
            title: "2001",
            albumArtist: "Dr. Dre",
            artwork: nil,
            //artwork: nsimage,
            genre: "Rap"))
    }
}
