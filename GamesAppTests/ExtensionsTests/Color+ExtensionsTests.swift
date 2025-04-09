//
//  Color+ExtensionsTests.swift
//  GamesAppTests
//
//  Created by Emre Yeşilyurt on 9.04.2025.
//

import XCTest
@testable import GamesApp
final class ColorExtensionsTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testTitleColor_isNotNil() {
        let color = UIColor.titleColor
        XCTAssertNotNil(color)
    }
    func testRateColor_isNotNil() {
        let color = UIColor.rateColor
        XCTAssertNotNil(color)
    }
    func testGenreColor_isNotNil() {
        let color = UIColor.genreColor
        XCTAssertNotNil(color)
    }
    func testDescriptionColor_isNotNil() {
        let color = UIColor.descriptionColor
        XCTAssertNotNil(color)
    }
}
