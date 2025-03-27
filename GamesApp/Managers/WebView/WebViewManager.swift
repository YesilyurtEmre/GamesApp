//
//  WebViewManager.swift
//  GamesApp
//
//  Created by Emre Yeşilyurt on 27.03.2025.
//

import UIKit
import WebKit

class WebViewManager {
    
    static let shared = WebViewManager()
    
    private init() {}
    
    func openWebView(from viewController: UIViewController, urlString: String) {
        guard let url = URL(string: urlString) else {
            AlertManager.shared.showErrorAlert(on: viewController, message: "Geçersiz URL.")
            return
        }
        
        let webViewVC = WebVC()
        webViewVC.url = url
        viewController.navigationController?.pushViewController(webViewVC, animated: true)
    }
}

