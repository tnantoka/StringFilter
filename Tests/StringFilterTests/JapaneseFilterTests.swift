//
//  JapaneseFilterTests.swift
//  StringFilter
//
//  Created by Tatsuya Tobioka on 1/18/16.
//  Copyright © 2016 Tatsuya Tobioka. All rights reserved.
//

import XCTest
@testable import StringFilter

class JapaneseFilterTests: XCTestCase {
    static let allTests = [
        ("testKana", testKana),
        ("testAlphabet", testAlphabet),
        ("testNumber", testNumber),
        ("testDefault", testDefault),
        ]
    
    func testKana() {
        XCTAssertEqual("あいうえおＡ".str_filter(.japanese(.hiragana, .katakana)), "アイウエオＡ")
        XCTAssertEqual("アイウエオＡ".str_filter(.japanese(.katakana, .hiragana)), "あいうえおＡ")
    }
    
    func testAlphabet() {
        XCTAssertEqual("ＡＢＣＤＥあ".str_filter(.japanese(.full(.alphabet), .half(.alphabet))), "ABCDEあ")
        XCTAssertEqual("ABCDEあ".str_filter(.japanese(.half(.alphabet), .full(.alphabet))), "ＡＢＣＤＥあ")
    }
    
    func testNumber() {
        XCTAssertEqual("０１２３４５６７８９あ".str_filter(.japanese(.full(.number), .half(.number))), "0123456789あ")
        XCTAssertEqual("0123456789あ".str_filter(.japanese(.half(.number), .full(.number))), "０１２３４５６７８９あ")
    }
    
    func testDefault() {
        XCTAssertEqual("test".str_filter(.japanese(.alphabet, .alphabet)), "test")
    }
}
