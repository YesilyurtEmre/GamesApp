//
//  GamesViewModelTests.swift
//  GamesAppTests
//
//  Created by Emre Yeşilyurt on 8.04.2025.
//

import XCTest
@testable import GamesApp

class MockGameService: GameServiceProtocol {
    var result: Result<[Game], Error>!
    
    func fetchGames(page: Int, completion: @escaping (Result<[Game], Error>) -> Void) {
        if let result = result {
            completion(result)
        }
    }
}

final class GamesViewModelTests: XCTestCase {
    
    var viewModel: GamesViewModel!
    var mockService: MockGameService!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        mockService = MockGameService()
        viewModel = GamesViewModel(service: mockService)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        viewModel = nil
        mockService = nil
    }
    
    func testFetchGamesSuccess() throws {
        let mockService = MockGameService()
        let mockGame = Game(id: 1, name: "GTA", backgroundImage: "image-url", metacritic: 90, genres: [Genre(name: "Action")], description: "GTA GAME")
        mockService.result = .success([mockGame])
        
        let viewModel = GamesViewModel(service: mockService)
        
        let expectation = XCTestExpectation(description: "Games fetched")
        
        viewModel.onGamesFetched = {
            expectation.fulfill()
        }
        
        viewModel.fetchGames()
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(viewModel.numberOfGames, 1)
        XCTAssertEqual(viewModel.game(at: 0).title, "GTA")
    }
    
    func testFetchGamesFailure() throws {
        let mockService = MockGameService()
        mockService.result = .failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Something went wrong"]))
        
        let viewModel = GamesViewModel(service: mockService)
        
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
    
}


