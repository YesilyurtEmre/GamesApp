//
//  GameResponseTests.swift
//  GamesAppTests
//
//  Created by Emre Yeşilyurt on 9.04.2025.
//

import XCTest
@testable import GamesApp
final class GameResponseTests: XCTestCase {
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
      "results": [
        {
          "id": 1,
          "name": "God of War",
          "background_image": "https://image.url",
          "metacritic": 94,
          "genres": [
            { "name": "Action" },
            { "name": "Adventure" }
          ],
          "description": "Kratos'un hikayesi"
        }
      ]
    }
    """.utf8)
    func test_GameResponse_DecodeSuccess() throws {
        let response = try JSONDecoder().decode(GameResponse.self, from: mockJSON)
        XCTAssertEqual(response.results.count, 1)
        let game = response.results.first
        XCTAssertEqual(game?.id, 1)
        XCTAssertEqual(game?.name, "God of War")
        XCTAssertEqual(game?.backgroundImage, "https://image.url")
        XCTAssertEqual(game?.metacritic, 94)
        XCTAssertEqual(game?.genres.count, 2)
        XCTAssertEqual(game?.genres.first?.name, "Action")
        XCTAssertEqual(game?.description, "Kratos'un hikayesi")
    }
}
