//
//  SDWebImage+Ext.swift
//  GamesApp
//
//  Created by Emre Yeşilyurt on 21.03.2025.
//

import UIKit
import SDWebImage

extension UIImageView {
  func loadImage(from url: URL) {
    self.sd_setImage(with: url, placeholderImage: nil, options: .highPriority, completed: nil)
  }
}
