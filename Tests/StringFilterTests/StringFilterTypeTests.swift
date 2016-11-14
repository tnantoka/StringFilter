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
    func transform(_ string: String) -> String {
        return string + "!"
    }
}

class StringFilterTypeTests: XCTestCase {
    static let allTests = [
        ("testFilter", testFilter),
        ("testReadme", testFilter),
        ]
    
    let string = "test"

    func testFilter() {
        let filter = StringFilter.uppercase * ExclaimFilter()
        XCTAssertEqual(string.str_filter(filter), "TEST!")
    }
    
    func testReadme() {
        let message = "ifmmp-!xpsme"
        let filters = [
            StringFilter.shift(-1),
            .capitalize,
            .replace("$", "!")
        ]
        XCTAssertEqual(message.str_filter(filters), "Hello, World!")
        
        let customFilter = ExclaimFilter() * 3 * StringFilter.uppercase
        XCTAssertEqual("Hello".str_filter(customFilter), "HELLO!!!")
    }
}
