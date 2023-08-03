import XCTest
@testable import MusicLibraryKit

final class MusicLibraryKitTests: XCTestCase {
    func testExample() throws {
        let service = try iTunesService()
        let musicLibrary = MusicLibrary(service: service)
        //print(musicLibrary.albumCollection)
        print(musicLibrary.playlistCollection)
    }
}
