//
//  EndPoints.swift
//  GamesApp
//
//  Created by Emre Yeşilyurt on 21.03.2025.
//

import Foundation

enum EndPoint {
    static let baseURL = "https://api.rawg.io/api"
    static let apiKey = "288a8f34ea0742f4ae1bd85d5b81687c"
    case games
    var path: String {
        switch self {
        case .games:
            return "/games"
        }
    }
    var url: String {
        return "\(EndPoint.baseURL)\(path)?key=\(EndPoint.apiKey)"
    }
}
