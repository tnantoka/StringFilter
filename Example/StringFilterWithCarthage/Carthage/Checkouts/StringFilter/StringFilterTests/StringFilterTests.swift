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
    
    let string = "test"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
 
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
    }
}
