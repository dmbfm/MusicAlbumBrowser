//
//  TagsStore.swift
//  MusicAlbumBrowser
//
//  Created by Daniel Fortes on 04/08/23.
//

import Foundation

struct TagsStore: Codable {
    var tags: [Tag] = []
    
    init() {
        self.tags = []
        do {
            try self.load()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

extension TagsStore {
    enum Errors: Error {
        case addExistingTagError
    }
}

extension TagsStore {
    static let  storeURL =  URL.applicationSupportDirectory.appendingPathComponent("MusicAlbumBrowser/tags.json", conformingTo: .json)

    
    func save() throws {
        let data = try JSONEncoder().encode(self)
        try data.write(to: Self.storeURL)
    }
    
    mutating func load() throws {
        let path = Self.storeURL.path(percentEncoded: false)
        if !FileManager.default.fileExists(atPath: path) {
            return
        }
        
        let data = try Data(contentsOf: Self.storeURL)
        self = try JSONDecoder().decode(Self.self, from: data)
    }
}

extension TagsStore {
    func fetchAllTags() -> [Tag] {
        return tags.sorted(by: \.name)
    }
}

extension TagsStore {
    func getTag(withID id: UUID) -> Tag? {
        return self.tags.first(where: { $0.id == id })
    }
    
    func getTag(withName name: String) -> Tag? {
        return self.tags.first(where: { $0.name == name })
    }
}

extension TagsStore {
    mutating func addTag(tag: Tag) throws {
        if !self.tags.contains(where: { $0.id == tag.id || $0.name == tag.name }) {
            self.tags.append(tag)
        }
        
        try self.save()
    }
}

extension TagsStore {
    mutating func removeTag(tag: Tag) throws {
        self.tags = self.tags.filter({ $0.id != tag.id })
        
        try self.save()
    }
}

extension TagsStore {
    mutating func updateTag(tag: Tag) throws {
        if let index = self.tags.firstIndex(where: { $0.id == tag.id }) {
            self.tags[index] = tag
        }
        
        try self.save()
    }
}


