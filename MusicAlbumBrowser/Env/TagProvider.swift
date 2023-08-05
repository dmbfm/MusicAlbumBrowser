//
//  Tags.swift
//  MusicAlbumBrowser
//
//  Created by Daniel Fortes on 04/08/23.
//

import Foundation
import MusicLibraryKit

class TagProvider: ObservableObject {
    @Published var tags: [Tag] = []
    var store = TagsStore()
    
    static let shared = TagProvider()
}

extension TagProvider {
    func fetchTags() {
        self.tags = self.store.fetchAllTags()
    }
}

extension TagProvider {
    func addTag(named name: String) {
        try! self.store.addTag(tag: Tag(name: name))
        self.fetchTags()
    }
}

extension TagProvider {
    func removeTag(tag: Tag) {
        try! self.store.removeTag(tag: tag)
        self.fetchTags()
    }
}

extension TagProvider {
    func updateTag(tag: Tag) {
        try! self.store.updateTag(tag: tag)
        self.fetchTags()
    }
}
