//
//  AlertManager.swift
//  GamesApp
//
//  Created by Emre Yeşilyurt on 27.03.2025.
//

import UIKit

class AlertManager {
  static let shared = AlertManager()
  private init() {}
  func showErrorAlert(on viewController: UIViewController, message: String) {
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    viewController.present(alert, animated: true)
  }
  func showFavoriteAddedAlert(on viewController: UIViewController, gameName: String) {
    let alert = UIAlertController(
      title: "Success",
      message: "\(gameName) has been added to your favorites!",
      preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    viewController.present(alert, animated: true)
  }
  func showFavoriteRemovedAlert(
    on viewController: UIViewController,
    gameName: String,
    isFromFavourites: Bool) {
      let alert = UIAlertController(
        title: "Success",
        message: "\(gameName) has been removed from your favorites!",
        preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
        if isFromFavourites {
          viewController.navigationController?.popViewController(animated: true)
        }
      }))
      viewController.present(alert, animated: true)
    }
}
