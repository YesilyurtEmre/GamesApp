//
//  GameDetailTests.swift
//  GamesAppTests
//
//  Created by Emre Yeşilyurt on 9.04.2025.
//

import XCTest
@testable import GamesApp
final class GameDetailTests: XCTestCase {
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
