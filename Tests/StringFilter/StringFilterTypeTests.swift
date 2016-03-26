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

#if os(Linux)
    extension StringFilterTypeTests: XCTestCaseProvider {
        var allTests: [(String, () throws -> Void)] {
            return [
                ("testFilter", testFilter),
                ("testReadme", testFilter),
            ]
        }
    }
#endif

class StringFilterTypeTests: XCTestCase {
    
    let string = "test"

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
