import XCTest
@testable import MusicLibraryKit

final class MusicLibraryKitTests: XCTestCase {
    func testExample() throws {
        let service = try iTunesService()
        let albums = service.fetchLibraryAlbums()
        let genres = GenreCollection(from: albums)
        print(genres)
    }
}
