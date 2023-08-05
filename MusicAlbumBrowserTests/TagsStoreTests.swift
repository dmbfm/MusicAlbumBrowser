//
//  TagsStoreTests.swift
//  MusicAlbumBrowserTests
//
//  Created by Daniel Fortes on 04/08/23.
//

import XCTest
@testable import MusicAlbumBrowser

final class TagsStoreTests: XCTestCase {
    
    func testBasic() throws {
        var store = TagsStore()
        try store.load()
        
        var tag = Tag(name: "Some Tag")
        try store.addTag(tag: tag)
        print("=============")
        print(store)
        print("=============")
        
        
        tag.name = "Other Tag"
        try store.updateTag(tag: tag)
        print("=============")
        print(store)
        print("=============")
        
    }
    
}
