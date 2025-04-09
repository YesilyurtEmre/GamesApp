//
//  GameDetailTests.swift
//  GamesAppTests
//
//  Created by Emre Yeşilyurt on 9.04.2025.
//

import XCTest
@testable import GamesApp
final class GameDetailTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    private let mockJSON = Data("""
    {
      "id": 99,
      "name": "The Witcher 3",
      "background_image": "https://image.url/witcher",
      "description": "Geralt'ın hikayesi",
      "website": "https://thewitcher.com",
      "reddit_url": "https://reddit.com/r/witcher"
    }
    """.utf8)
    func test_GameDetail_DecodeSuccess() throws {
        let detail = try JSONDecoder().decode(GameDetail.self, from: mockJSON)
        XCTAssertEqual(detail.id, 99)
        XCTAssertEqual(detail.name, "The Witcher 3")
        XCTAssertEqual(detail.backgroundImage, "https://image.url/witcher")
        XCTAssertEqual(detail.description, "Geralt'ın hikayesi")
        XCTAssertEqual(detail.website, "https://thewitcher.com")
        XCTAssertEqual(detail.redditURL, "https://reddit.com/r/witcher")
    }
}
