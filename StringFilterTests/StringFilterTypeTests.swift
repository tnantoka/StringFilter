//
//  StringFilterTypeTests.swift
//  StringFilter
//
//  Created by Tatsuya Tobioka on 1/18/16.
//  Copyright © 2016 Tatsuya Tobioka. All rights reserved.
//

import XCTest
@testable import StringFilter

struct ExclaimFilter: StringFilterType {
    func transform(string: String) -> String {
        return string + "!"
    }
}

class StringFilterTypeTests: XCTestCase {
    
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
    
    func testFilter() {
        let filter = StringFilter.Uppercase * ExclaimFilter()
        XCTAssertEqual(string.str_filter(filter), "TEST!")
    }
    
    func testReadme() {
        let message = "ifmmp-!xpsme"
        let filters = [
            StringFilter.Shift(-1),
            .Capitalize,
            .Replace("$", "!")
        ]
        XCTAssertEqual(message.str_filter(filters), "Hello, World!")
        
        let customFilter = ExclaimFilter() * 3 * StringFilter.Uppercase
        XCTAssertEqual("Hello".str_filter(customFilter), "HELLO!!!")
    }
}
