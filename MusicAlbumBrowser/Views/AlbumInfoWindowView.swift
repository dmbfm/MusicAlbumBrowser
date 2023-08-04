//
//  AlbumInfoWindowView.swift
//  MusicAlbumBrowser
//
//  Created by Daniel Fortes on 03/08/23.
//

import SwiftUI
import MusicLibraryKit

struct AlbumInfoWindowView: View {
    
    let album: Album?
    
    var body: some View {
        VStack {
            if let album = album {
                
                if let image = album.originalArtwork {
                    Image(nsImage: image)
                        .resizable()
                        .frame(width: 512, height: 512)
                }
                
                VStack {
                    Text(album.title)
                        .font(.largeTitle)
                    Text(album.artist)
                }
                
                Button {
                    playAlbum(album: album)
                } label: {
                    ZStack {
                        HStack {
                            Image(systemName: "music.note")
                            Text("Play In Music")
                        }
                    }
                    .padding(.horizontal, 6)
                    .padding(.vertical, 6)
                }
                .buttonStyle(.plain)
                .background(LinearGradient(colors: [.pink, .red], startPoint: .bottomLeading, endPoint: .topTrailing))
                .cornerRadius(4)
                .foregroundColor(.white)
                .padding(.bottom)
            }
        }
    }
}

struct AlbumInfoWindowView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumInfoWindowView(album: PreviewData.previewAlbum)
            .previewLayout(.sizeThatFits)
    }
}
