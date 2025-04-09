//
//  MockGameService.swift
//  GamesAppTests
//
//  Created by Emre Yeşilyurt on 9.04.2025.
//

import Foundation
@testable import GamesApp
final class MockGameService: GameServiceProtocol {
    var result: Result<[Game], Error>!
    func fetchGames(page: Int, completion: @escaping (Result<[Game], Error>) -> Void) {
        if let result = result {
            completion(result)
        }
    }
}
