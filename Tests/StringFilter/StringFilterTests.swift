//
//  StringFilterTests.swift
//  StringFilterTests
//
//  Created by Tatsuya Tobioka on 1/17/16.
//  Copyright © 2016 Tatsuya Tobioka. All rights reserved.
//

import XCTest
@testable import StringFilter

#if os(Linux)
    extension StringFilterTests: XCTestCaseProvider {
        var allTests: [(String, () throws -> Void)] {
            return [
                ("testEmpty", testEmpty),
                ("testCapitalize", testCapitalize),
                ("testLowercase", testLowercase),
                ("testUppercase", testUppercase),
                ("testShift", testShift),
                ("testRepeat", testRepeat),
                ("testReplace", testReplace),
                ("testMultiply", testMultiply),
            ]
        }
    }
#endif

class StringFilterTests: XCTestCase {
    
    let string = "test"
    
    func testEmpty() {
        XCTAssertEqual(string.str_filter(.Empty), string)
    }
    
    func testCapitalize() {
        XCTAssertEqual(string.str_filter(.Capitalize), "Test")
    }

    func testLowercase() {
        XCTAssertEqual(string.uppercaseString.str_filter(.Lowercase), "test")
    }

    func testUppercase() {
        XCTAssertEqual(string.uppercaseString.str_filter(.Uppercase), "TEST")
    }

    func testShift() {
        XCTAssertEqual(string.str_filter(.Shift(1)), "uftu")
    }

    func testRepeat() {
        XCTAssertEqual(string.str_filter(.Repeat(2)), "testtest")
    }

    func testReplace() {
        XCTAssertEqual(string.str_filter(.Replace("t", "T")), "TesT")
    }

    func testMultiply() {
        XCTAssertEqual(string.str_filter([.Uppercase, .Shift(1), .Replace("U", "u")]), "uFTu")
        XCTAssertEqual(string.str_filter(StringFilter.Shift(1) * 3), "whvw")
        XCTAssertEqual(string.str_filter(3 * StringFilter.Shift(1)), "whvw")
        XCTAssertEqual(string.str_filter(StringFilter.Shift(1) * 0), string)
    }
}
