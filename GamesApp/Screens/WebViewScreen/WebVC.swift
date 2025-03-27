//
//  WebVC.swift
//  GamesApp
//
//  Created by Emre Yeşilyurt on 27.03.2025.
//

import UIKit
import WebKit

class WebVC: UIViewController {
    
    var url: URL?
    
    private let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupWebView()
    }
    
    private func setupWebView() {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        if let url = url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

