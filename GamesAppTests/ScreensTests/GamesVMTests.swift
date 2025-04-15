//
//  GamesVMTests.swift
//  GamesAppTests
//
//  Created by Emre Yeşilyurt on 15.04.2025.
//

import XCTest
@testable import GamesApp
final class GamesVMTests: XCTestCase {
  var viewModel: GamesViewModel!
  var mockService: MockGameService!
  override func setUpWithError() throws {
    mockService = MockGameService()
    viewModel = GamesViewModel(service: mockService)
  }
  override func tearDownWithError() throws {
    viewModel = nil
    mockService = nil
  }
  func testFetchGamesSuccess() throws {
    let mockGame = Game(id: 1,
                        name: "GTA",
                        backgroundImage: "image-url",
                        metacritic: 90,
                        genres: [Genre(name: "Action")],
                        description: "GTA GAME")
    mockService.result = .success([mockGame])
    let expectation = XCTestExpectation(description: "GTA GAME")
    viewModel.onGamesFetched = {
      expectation.fulfill()
    }
    viewModel.fetchGames()
    wait(for: [expectation], timeout: 1.0)
    XCTAssertEqual(viewModel.numberOfGames, 1)
    XCTAssertEqual(viewModel.game(at: 0).title, "GTA")
  }
  func testFetchGamesFailure() throws {
    mockService.result = .failure(NSError(domain: "",
                                          code: -1,
                                          userInfo: [NSLocalizedDescriptionKey: "Something went wrong"]))
    let expectation = XCTestExpectation(description: "Error handled")
    var receivedError: String?
    viewModel.onError = { error in
      receivedError = error
      expectation.fulfill()
    }
    viewModel.fetchGames()
    wait(for: [expectation], timeout: 1.0)
    XCTAssertEqual(receivedError, "Something went wrong")
  }
  func testSearchGamesSuccess() {
    let mockGame1 = Game(id: 1,
                         name: "GTA",
                         backgroundImage: "image-url",
                         metacritic: 90,
                         genres: [Genre(name: "Action")],
                         description: "GTA GAME")
    let mockGame2 = Game(id: 2,
                         name: "Minecraft",
                         backgroundImage: "image-url",
                         metacritic: 85,
                         genres: [Genre(name: "Adventure")],
                         description: "Minecraft GAME")
    mockService.searchResult = .success([mockGame1, mockGame2])
    let expectation = XCTestExpectation(description: "Games searched")
    viewModel.searchGames(with: "GTA") { results in
      XCTAssertEqual(results.count, 1)
      XCTAssertEqual(results.first?.title, "GTA")
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 1.0)
  }
}
