//
//  GamesDetailViewModel.swift
//  GamesApp
//
//  Created by Emre Yeşilyurt on 21.03.2025.
//

import Foundation
import UIKit

struct GameDetailViewModelItem {
    let id: Int
    let title: String
    let description: String
    let redditURL: String
    let websiteURL: String
    let imageURL: String
}

class GameDetailViewModel {
    private(set) var gameDetailItem: GameDetailViewModelItem?
    var onDataFetched: (() -> Void)?
    func fetchGameDetail(gameId: Int) {
        APIService.shared.fetchGameDetails(gameId: gameId) { [weak self] result in
            switch result {
            case .success(let gameDetail):
                let item = GameDetailViewModelItem(
                    id: gameDetail.id,
                    title: gameDetail.name,
                    description: gameDetail.description,
                    redditURL: gameDetail.redditURL ?? "",
                    websiteURL: gameDetail.website ?? "",
                    imageURL: gameDetail.backgroundImage ?? ""
                )
                self?.gameDetailItem = item
                self?.onDataFetched?()
            case .failure(let error):
                print("Game Detail Error: \(error.localizedDescription)")
            }
        }
    }
    func cleanHTMLTags(from htmlString: String) -> String {
        if let data = htmlString.data(using: .utf8) {
            do {
                let attributedString = try NSAttributedString(
                    data: data,
                    options: [
                        .documentType: NSAttributedString.DocumentType.html],
                    documentAttributes: nil)
                return attributedString.string
            } catch {
                print("Error cleaning HTML tags: \(error.localizedDescription)")
            }
        }
        return htmlString
    }
    func isValidURL(_ urlString: String) -> Bool {
        guard let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) else {
            return false
        }
        return true
    }
}
