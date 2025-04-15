//
//  GameModelTests.swift
//  GamesAppTests
//
//  Created by Emre Yeşilyurt on 15.04.2025.
//

import XCTest
@testable import GamesApp
final class GameModelTests: XCTestCase {
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
  func test_GameModel_DecodeSuccess() throws {
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
