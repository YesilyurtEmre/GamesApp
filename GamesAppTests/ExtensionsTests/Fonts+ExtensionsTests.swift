//
//  Fonts+ExtensionsTests.swift
//  GamesAppTests
//
//  Created by Emre Yeşilyurt on 9.04.2025.
//

import XCTest
@testable import GamesApp
final class FontsExtensionsTests: XCTestCase {
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
    func test_robotoBold_isNotNil() {
        let font = UIFont.robotoBold(ofSize: 16)
        XCTAssertNotNil(font)
    }
    func test_robotoRegular_isNotNil() {
        let font = UIFont.robotoRegular(ofSize: 16)
        XCTAssertNotNil(font)
    }
    func test_robotoLight_isNotNil() {
        let font = UIFont.robotoLight(ofSize: 16)
        XCTAssertNotNil(font)
    }
}
