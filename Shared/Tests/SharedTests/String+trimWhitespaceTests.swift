import XCTest
@testable import Shared

final class StringTrimWhitespacesTests: XCTestCase {
    func test() throws {
       
        let string = "   OKxxx             "
        let result = string.trimWhitespaces()
        let exptected = "OKxxx"
        
        XCTAssertEqual(result, exptected)
        
        let string2 = "            "
        XCTAssertEqual("", string2.trimWhitespaces())
    }
}
