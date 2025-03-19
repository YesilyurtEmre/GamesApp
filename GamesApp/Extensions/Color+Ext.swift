//
//  Color+Ext.swift
//  GamesApp
//
//  Created by Emre Yeşilyurt on 19.03.2025.
//

import UIKit

extension UIColor {
    static var titleColor: UIColor {
        return UIColor(named: "PrimaryBlack") ?? .black
    }

    static var rateColor: UIColor {
        return UIColor(named: "AlertRed") ?? .red
    }

    static var genreColor: UIColor {
        return UIColor(named: "GrayText") ?? .gray
    }

    static var descriptionColor: UIColor {
        return UIColor(named: "DarkGray") ?? .darkGray
    }
}

