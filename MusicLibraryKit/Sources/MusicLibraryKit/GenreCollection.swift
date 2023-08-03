//
//  File.swift
//  
//
//  Created by Daniel Fortes on 02/08/23.
//

import Foundation

public struct GenreCollection {
    public var genres: [UUID: Genre] = [:]
}

extension GenreCollection {
    init(from albumCollection: AlbumCollection) {
        var genreSet = Set<String>()
        
        for (_, album) in albumCollection.albums {
            genreSet.insert(album.genre)
        }
        
        for genre in genreSet {
            let id = UUID()
            self.genres[UUID()] = Genre(id: id, name: genre )
        }
    }
}
