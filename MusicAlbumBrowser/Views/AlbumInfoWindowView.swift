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
                .padding()
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
