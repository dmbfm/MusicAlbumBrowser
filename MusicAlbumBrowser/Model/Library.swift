//
//  Library.swift
//  musicshit
//
//  Created by Daniel Fortes on 01/08/23.
//

import Foundation
import AppKit

enum AlbumFilter {
    case none
    case genre(String)
}

class Library: ObservableObject {
    
    @Published var albums: [Album] = []
    @Published var sortedAlbums: [Album] = []
    @Published var genres: Set<String> = []
    @Published var filteredGenres: Set<String> = []
    
    var albumFilter: AlbumFilter = .none
    
    var genresFilterString: String = "" {
        didSet {
            self.updateFilteredGenres()
        }
    }
    
    init() {
        self.albums = []
        self.sortedAlbums = []
    }
    
    init(albums: [Album]) {
        self.albums = albums
        self.sortAndFilter()
    }
    
    var sortType: SortType = .artist  {
        didSet {
            if sortType == sortTypeSecond {
                switch sortType {
                case .album:
                    sortTypeSecond = .artist
                case .artist:
                    sortTypeSecond = .album
                }
                return
            }
            sortAndFilter()
        }
    }
    
    var sortTypeSecond: SortType = .album {
        didSet {
            sortAndFilter()
        }
    }
    
    var sortOrder: Foundation.SortOrder = .forward {
        didSet {
            sortAndFilter()
        }
    }
    
    var firstComparator: KeyPathComparator<Album> {
        switch self.sortType {
        case .album:
            return KeyPathComparator(\.title, order: sortOrder)
        case .artist:
            return KeyPathComparator(\.albumArtist, order: sortOrder)
        }
    }
    
    var secondComparator: KeyPathComparator<Album> {
        switch self.sortTypeSecond {
        case .album:
            return KeyPathComparator(\.title, order: sortOrder)
        case .artist:
            return KeyPathComparator(\.albumArtist, order: sortOrder)
        }
    }
    
    func sortAndFilter() {
        self.sortedAlbums = albums.sorted(using: [firstComparator, secondComparator])
        
        guard case .genre(let genre) = self.albumFilter else {
            return
        }
        
        self.sortedAlbums = sortedAlbums.filter({ $0.genre == genre})
    }
    
    func filterGenres(by searchString: String) {
        self.filteredGenres = self.genres.filter({ $0.contains(searchString) })
    }
    
    func fetchAlbums() throws {
        if isPreview() {
            return
        }
        
        let service = try iTunesService()
        self.albums = service.fetchAlbums()
        sortAndFilter()
        updateGenres()
    }
    
    func updateGenres() {
        self.genres = []
        
        for album in albums {
            if album.genre != "" {
                self.genres.insert(album.genre)
            }
        }
        
        self.updateFilteredGenres()
    }
    
    func updateFilteredGenres() {
        if genresFilterString == "" {
            self.filteredGenres = self.genres
        } else {
            self.filteredGenres = self.genres.filter({ $0.localizedCaseInsensitiveContains(self.genresFilterString) })
        }
    }
    
    func isPreview() -> Bool {
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}


extension Library {
    static var sampleAlbums: [Album] = [
        Album(id: 1,
              title: "2001",
              albumArtist: "Dr. Dre",
              artwork: NSImage(named: "dr_dre_2001")!,
              genre: "Hip-Hop/Rap"
             ),
    ]
    
    static func preview() -> Library {
        return .init(albums: Self.sampleAlbums)
    }
}
