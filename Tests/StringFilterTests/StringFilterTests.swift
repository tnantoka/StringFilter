//
//  StringFilterTests.swift
//  StringFilterTests
//
//  Created by Tatsuya Tobioka on 1/17/16.
//  Copyright © 2016 Tatsuya Tobioka. All rights reserved.
//

import XCTest
@testable import StringFilter

class StringFilterTests: XCTestCase {
    static let allTests = [
        ("testEmpty", testEmpty),
        ("testCapitalize", testCapitalize),
        ("testLowercase", testLowercase),
        ("testUppercase", testUppercase),
        ("testShift", testShift),
        ("testRepeat", testRepeat),
        ("testReplace", testReplace),
        ("testMultiply", testMultiply),
        ]
    
    let string = "test"
    
    func testEmpty() {
        XCTAssertEqual(string.str_filter(.empty), string)
    }
    
    func testCapitalize() {
        XCTAssertEqual(string.str_filter(.capitalize), "Test")
    }

    func testLowercase() {
        XCTAssertEqual(string.uppercased().str_filter(.lowercase), "test")
    }

    func testUppercase() {
        XCTAssertEqual(string.uppercased().str_filter(.uppercase), "TEST")
    }

    func testShift() {
        XCTAssertEqual(string.str_filter(.shift(1)), "uftu")
    }

    func testRepeat() {
        XCTAssertEqual(string.str_filter(.repeat(2)), "testtest")
    }

    func testReplace() {
        XCTAssertEqual(string.str_filter(.replace("t", "T")), "TesT")
    }

    func testMultiply() {
        XCTAssertEqual(string.str_filter([.uppercase, .shift(1), .replace("U", "u")]), "uFTu")
        XCTAssertEqual(string.str_filter(StringFilter.shift(1) * 3), "whvw")
        XCTAssertEqual(string.str_filter(3 * StringFilter.shift(1)), "whvw")
        XCTAssertEqual(string.str_filter(StringFilter.shift(1) * 0), string)
    }
}
