//
//  JapaneseFilterTests.swift
//  StringFilter
//
//  Created by Tatsuya Tobioka on 1/18/16.
//  Copyright © 2016 Tatsuya Tobioka. All rights reserved.
//

import XCTest
@testable import StringFilter

#if os(Linux)
    extension JapaneseFilterTests: XCTestCaseProvider {
        var allTests: [(String, () throws -> Void)] {
            return [
                ("testKana", testKana),
                ("testAlphabet", testAlphabet),
                ("testNumber", testNumber),
                ("testDefault", testDefault),
            ]
        }
    }
#endif

class JapaneseFilterTests: XCTestCase {
    
    func testKana() {
        XCTAssertEqual("あいうえおＡ".str_filter(.Japanese(.Hiragana, .Katakana)), "アイウエオＡ")
        XCTAssertEqual("アイウエオＡ".str_filter(.Japanese(.Katakana, .Hiragana)), "あいうえおＡ")
    }
    
    func testAlphabet() {
        XCTAssertEqual("ＡＢＣＤＥあ".str_filter(.Japanese(.Full(.Alphabet), .Half(.Alphabet))), "ABCDEあ")
        XCTAssertEqual("ABCDEあ".str_filter(.Japanese(.Half(.Alphabet), .Full(.Alphabet))), "ＡＢＣＤＥあ")
    }
    
    func testNumber() {
        XCTAssertEqual("０１２３４５６７８９あ".str_filter(.Japanese(.Full(.Number), .Half(.Number))), "0123456789あ")
        XCTAssertEqual("0123456789あ".str_filter(.Japanese(.Half(.Number), .Full(.Number))), "０１２３４５６７８９あ")
    }
    
    func testDefault() {
        XCTAssertEqual("test".str_filter(.Japanese(.Alphabet, .Alphabet)), "test")
    }
}
