//
//  Color+ExtTests.swift
//  GamesAppTests
//
//  Created by Emre Yeşilyurt on 15.04.2025.
//

import XCTest
@testable import GamesApp
final class ColorExtensionsTests: XCTestCase {
  func testTitleColor_isExpectedColor() {
    let color = UIColor.titleColor
    let expectedColor = UIColor(named: "PrimaryBlack", in: .main, compatibleWith: nil) ?? .black
    XCTAssertEqual(color, expectedColor)
  }
  func testRateColor_isExpectedColor() {
    let color = UIColor.rateColor
    let expectedColor = UIColor(named: "AlertRed", in: .main, compatibleWith: nil) ?? .black
    XCTAssertEqual(color, expectedColor)
  }
  func testGenreColor_isExpectedColor() {
    let color = UIColor.genreColor
    let expectedColor = UIColor(named: "GrayText", in: .main, compatibleWith: nil) ?? .black
    XCTAssertEqual(color, expectedColor)
  }
  func testDescriptionColor_isExpectedColor() {
    let color = UIColor.descriptionColor
    let expectedColor = UIColor(named: "DarkGrayText", in: .main, compatibleWith: nil) ?? .black
    XCTAssertEqual(color, expectedColor)
  }
}
