//
//  Fonts+ExtensionsTests.swift
//  GamesAppTests
//
//  Created by Emre Yeşilyurt on 9.04.2025.
//

import XCTest
@testable import GamesApp

final class FontsExtensionsTests: XCTestCase {
  func test_robotoBold_isExpectedFont() {
    let font = UIFont.robotoBold(ofSize: 16)
    let expectedFont = UIFont(name: "Roboto-Bold", size: 16)
    XCTAssertEqual(font.fontName, expectedFont?.fontName)
  }
  func test_robotoRegular_isExpectedFont() {
    let font = UIFont.robotoRegular(ofSize: 16)
    let expectedFont = UIFont(name: "Roboto-Regular", size: 16)
    XCTAssertEqual(font.fontName, expectedFont?.fontName)
  }
  func test_robotoMedium_isExpectedFont() {
    let font = UIFont.robotoMedium(ofSize: 16)
    let expectedFont = UIFont(name: "Roboto-Medium", size: 16)
    XCTAssertEqual(font.fontName, expectedFont?.fontName)
  }
}
