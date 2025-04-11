//
//  GameDetailVMTests.swift
//  GamesAppTests
//
//  Created by Emre Yeşilyurt on 10.04.2025.
//

import XCTest
@testable import GamesApp

final class GameDetailVMTests: XCTestCase {
  var viewModel: GameDetailViewModel!
  var mockService: MockGameService!
  override func setUpWithError() throws {
    mockService = MockGameService()
    viewModel = GameDetailViewModel(gameService: mockService)
  }
  override func tearDownWithError() throws {
    mockService = nil
    viewModel = nil
  }
  func testFetchGameDetail_Success() throws {
    let mockGameDetail = GameDetail(id: 1,
                                    name: "Game 1",
                                    backgroundImage: "url",
                                    description: "Description",
                                    website: "website.com",
                                    redditURL: "reddit.com")
    mockService.gameDetailResult = .success(mockGameDetail)
    var fetchedGameDetail: GameDetailViewModelItem?
    viewModel.onDataFetched = {
      if let gameDetailItem = self.viewModel.gameDetailItem {
        fetchedGameDetail = gameDetailItem
      }
    }
    viewModel.fetchGameDetail(gameId: 1)
    XCTAssertNotNil(fetchedGameDetail)
    XCTAssertEqual(fetchedGameDetail?.id, 1)
    XCTAssertEqual(fetchedGameDetail?.title, "Game 1")
    XCTAssertEqual(fetchedGameDetail?.description, "Description")
  }
  func testFetchGameDetail_Failure() throws {
    mockService.result = .failure(NSError(domain: "", code: 1, userInfo: nil))
    var errorOccurred = false
    viewModel.onDataFetched = {
      errorOccurred = true
    }
    viewModel.fetchGameDetail(gameId: 1)
    XCTAssertFalse(errorOccurred)
  }
  func testCleanHTMLTags() throws {
    let htmlString = "<p>This is <strong>HTML</strong> content.</p>"
    let cleanedString = viewModel.cleanHTMLTags(from: htmlString)
    XCTAssertEqual(cleanedString, "This is HTML content.")
  }
  func testIsValidURL() throws {
    let validURL = "https://www.example.com"
    XCTAssertTrue(viewModel.isValidURL(validURL))
    let invalidURL = "invalid-url"
    XCTAssertFalse(viewModel.isValidURL(invalidURL))
  }
}
